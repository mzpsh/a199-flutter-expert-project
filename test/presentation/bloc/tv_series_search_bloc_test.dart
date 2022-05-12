import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTVSeries extends Mock implements SearchTVSeries {}

void main() {
  late SearchTVSeries usecase;
  late TvSeriesSearchBloc bloc;
  const testQuery = 'sixtyninexxxx';

  setUp(() {
    usecase = MockSearchTVSeries();
    bloc = TvSeriesSearchBloc(usecase);
  });
  group('TvSeriesSearchBloc', () {
    test('initial state should be empty', () {
      expect(bloc.state, TvSeriesSearchEmpty());
    });

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
        'emits [Loading, HasData] when OnQueryChangedTvSeriesSearch is added.',
        build: () {
          when(() => usecase.execute(testQuery))
              .thenAnswer((_) async => Right([testTVSeries]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnQueryChangedTvSeriesSearch(testQuery)),
        expect: () => [
              TvSeriesSearchLoading(),
              TvSeriesSearchHasData([testTVSeries])
            ],
        verify: (bloc) => verify(() => usecase.execute(testQuery)));

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
        'emits [Loading, Error] when OnQueryChangedTvSeriesSearch is added and error.',
        build: () {
          when(() => usecase.execute(testQuery))
              .thenAnswer((_) async => Left(ServerFailure('message')));
          return bloc;
        },
        act: (bloc) => bloc.add(OnQueryChangedTvSeriesSearch(testQuery)),
        expect: () => [TvSeriesSearchLoading(), TvSeriesSearchError('message')],
        verify: (bloc) => verify(() => usecase.execute(testQuery)));
  });
}
