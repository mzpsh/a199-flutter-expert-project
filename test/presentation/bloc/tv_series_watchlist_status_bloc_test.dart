import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/write_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockReadWatchlistTVSeries extends Mock implements ReadWatchlistTVSeries {}

class MockWriteWatchlistTVSeries extends Mock
    implements WriteWatchlistTVSeries {}

void main() {
  late ReadWatchlistTVSeries readWatchlistTVSeries;
  late WriteWatchlistTVSeries writeWatchlistTVSeries;
  late TvSeriesWatchlistStatusBloc bloc;

  setUp(() {
    readWatchlistTVSeries = MockReadWatchlistTVSeries();
    writeWatchlistTVSeries = MockWriteWatchlistTVSeries();
    bloc = TvSeriesWatchlistStatusBloc(
        readWatchlistTVSeries: readWatchlistTVSeries,
        writeWatchlistTVSeries: writeWatchlistTVSeries);
  });
  group('TvSeriesWatchlistStatusBloc', () {
    test('initial state should be loading', () {
      expect(bloc.state, TvSeriesWatchlistStatusLoading());
    });

    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emits [Loading, IsIn] when OnCheckTvSeriesWatchlistStatus is added.',
      build: () {
        when(() => readWatchlistTVSeries.execute())
            .thenAnswer((_) async => [testTVSeries]);
        return bloc;
      },
      act: (bloc) => bloc.add(OnCheckTvSeriesWatchlistStatus(testTVSeries)),
      expect: () =>
          [TvSeriesWatchlistStatusLoading(), TvSeriesWatchlistStatusIsIn(true)],
      verify: (bloc) => verify(() => readWatchlistTVSeries.execute()),
    );

    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emits [Loading, IsIn(false)] when OnCheckTvSeriesWatchlistStatus is added but nothing in wathlist.',
      build: () {
        when(() => readWatchlistTVSeries.execute()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(OnCheckTvSeriesWatchlistStatus(testTVSeries)),
      expect: () => [
        TvSeriesWatchlistStatusLoading(),
        TvSeriesWatchlistStatusIsIn(false)
      ],
      verify: (bloc) => verify(() => readWatchlistTVSeries.execute()),
    );

    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emits [Loading, IsIn] when OnToggleTvSeriesWatchlistStatus is added.',
      build: () {
        when(() => readWatchlistTVSeries.execute()).thenAnswer((_) async => []);
        when(() => writeWatchlistTVSeries.execute([testTVSeries]))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnToggleTvSeriesWatchlistStatus(testTVSeries)),
      expect: () =>
          [TvSeriesWatchlistStatusLoading(), TvSeriesWatchlistStatusIsIn(true)],
      verify: (bloc) =>
          verify(() => writeWatchlistTVSeries.execute([testTVSeries])),
    );
    blocTest<TvSeriesWatchlistStatusBloc, TvSeriesWatchlistStatusState>(
      'emits [Loading, IsIn(false)] when OnToggleTvSeriesWatchlistStatus is added but the list already contain such TVSeries.',
      build: () {
        when(() => readWatchlistTVSeries.execute())
            .thenAnswer((_) async => [testTVSeries]);
        when(() => writeWatchlistTVSeries.execute([]))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnToggleTvSeriesWatchlistStatus(testTVSeries)),
      expect: () => [
        TvSeriesWatchlistStatusLoading(),
        TvSeriesWatchlistStatusIsIn(false)
      ],
      verify: (bloc) => verify(() => writeWatchlistTVSeries.execute([])),
    );
  });
}
