import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockReadWatchlistTVSeries extends Mock implements ReadWatchlistTVSeries {}

void main() {
  late ReadWatchlistTVSeries usecase;
  late TvSeriesWatchlistBloc bloc;

  setUp(() {
    usecase = MockReadWatchlistTVSeries();
    bloc = TvSeriesWatchlistBloc(usecase);
  });
  group('TvSeriesWatchlistBloc', () {
    test('initial state should be loading', () {
      expect(bloc.state, TVSeriesWatchlistLoading());
    });

    blocTest<TvSeriesWatchlistBloc, TVSeriesWatchlistState>(
        'emits [MyState] when MyEvent is added.',
        build: () {
          when(() => usecase.execute()).thenAnswer((_) async => [testTVSeries]);
          return bloc;
        },
        act: (bloc) => bloc.add(OnLoadTVSeriesWatchlist()),
        expect: () => [
              TVSeriesWatchlistLoading(),
              TVSeriesWatchlistHasData([testTVSeries])
            ],
        verify: (bloc) => verify(() => usecase.execute()));
  });
}
