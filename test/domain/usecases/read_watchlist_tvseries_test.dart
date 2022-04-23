import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVSeriesRepository extends Mock implements TVSeriesRepository {}

void main() {
  final repository = MockTVSeriesRepository();
  final usecase = ReadWatchlistTVSeries(repository);
  test('should return a List of TVSeries', () async {
    when(() => repository.readWatchlistTVSeries())
        .thenAnswer((realInvocation) async => <TVSeries>[]);

    final result = await usecase.execute();

    expect(result, <TVSeries>[]);
  });
}
