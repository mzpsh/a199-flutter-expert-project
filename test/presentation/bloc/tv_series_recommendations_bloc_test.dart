import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTVSeriesRecommendations extends Mock
    implements GetTVSeriesRecommendations {}

void main() {
  late GetTVSeriesRecommendations usecase;
  late TvSeriesRecommendationsBloc bloc;
  const testId = 69;
  setUp(() {
    usecase = MockGetTVSeriesRecommendations();
    bloc = TvSeriesRecommendationsBloc(usecase);
  });
  group('TvSeriesRecommendationsBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, TvSeriesRecommendationsLoading());
    });

    blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
        'emits [Loading, HasData] when OnFetchTvSeriesRecommendation is added.',
        build: () {
          when(() => usecase.execute(testId))
              .thenAnswer((invocation) async => Right([testTVSeries]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesRecommendation(testId)),
        expect: () => <TvSeriesRecommendationsState>[
              TvSeriesRecommendationsLoading(),
              TvSeriesRecommendationsHasData([testTVSeries])
            ],
        verify: (bloc) => verify(() => usecase.execute(testId)));

    blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
        'emits [Loading, Error] when OnFetchTvSeriesRecommendation is added and error.',
        build: () {
          when(() => usecase.execute(testId))
              .thenAnswer((invocation) async => Left(ServerFailure('message')));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchTvSeriesRecommendation(testId)),
        expect: () => <TvSeriesRecommendationsState>[
              TvSeriesRecommendationsLoading(),
              TvSeriesRecommendationsError('message')
            ],
        verify: (bloc) => verify(() => usecase.execute(testId)));
  });
}
