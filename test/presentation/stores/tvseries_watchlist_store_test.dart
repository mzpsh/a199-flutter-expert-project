import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/write_watchlist_tvseries.dart';
import 'package:ditonton/presentation/stores/tvseries_watchlist_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockReadWatchlistTVSeries extends Mock implements ReadWatchlistTVSeries {}

class MockWriteWatchlistTVSeries extends Mock
    implements WriteWatchlistTVSeries {}

void main() {
  late MockReadWatchlistTVSeries mockReadWatchlistTVSeries;
  late MockWriteWatchlistTVSeries mockWriteWatchlistTVSeries;

  setUp(() {
    mockReadWatchlistTVSeries = MockReadWatchlistTVSeries();
    mockWriteWatchlistTVSeries = MockWriteWatchlistTVSeries();
  });
  test('should return a TVSeries list as state initiated', () async {
    when(() => mockReadWatchlistTVSeries.execute())
        .thenAnswer((invocation) async => <TVSeries>[testTVSeries]);

    final store = TVSeriesWatchlistStore(
        readWatchlistTVSeries: mockReadWatchlistTVSeries,
        writeWatchlistTVSeries: mockWriteWatchlistTVSeries);

    await store.initWatchlist();

    expect(store.state, <TVSeries>[testTVSeries]);
  });

  test('should add a TVSeries to watchlist if not already there.', () async {
    when(() => mockReadWatchlistTVSeries.execute())
        .thenAnswer((invocation) async => <TVSeries>[]);
    when(() => mockWriteWatchlistTVSeries.execute([testTVSeries]))
        .thenAnswer((invocation) async => true);

    final store = TVSeriesWatchlistStore(
        readWatchlistTVSeries: mockReadWatchlistTVSeries,
        writeWatchlistTVSeries: mockWriteWatchlistTVSeries);

    await store.initWatchlist();
    await store.toggleToWatchlist(testTVSeries);

    expect(store.state, <TVSeries>[testTVSeries]);
  });

  test('should remove a TVSeries to watchlist if it is already there.',
      () async {
    when(() => mockReadWatchlistTVSeries.execute())
        .thenAnswer((invocation) async => <TVSeries>[testTVSeries]);
    // when(() => mockWriteWatchlistTVSeries.execute)
    //     .thenReturn((List<TVSeries> list) async => true);
    when(() => mockWriteWatchlistTVSeries.execute([]))
        .thenAnswer((invocation) async => true);

    final store = TVSeriesWatchlistStore(
        readWatchlistTVSeries: mockReadWatchlistTVSeries,
        writeWatchlistTVSeries: mockWriteWatchlistTVSeries);

    await store.initWatchlist();
    await store.toggleToWatchlist(testTVSeries);

    expect(store.state, <TVSeries>[]);
  });
}
