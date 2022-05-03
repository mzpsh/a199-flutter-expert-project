import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationsBloc bloc;
  int testId = 69;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    bloc = MovieRecommendationsBloc(usecase);
  });

  group('MovieRecommendationsBloc', () {
    test('initial state should be empty.', () {
      expect(bloc.state, MovieRecommendationsEmpty());
    });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'emits [Loading, HasData] when OnFetchMovieRecommendations is added.',
        build: () {
          when(() => usecase.execute(testId))
              .thenAnswer((_) async => Right([testMovie]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(testId)),
        expect: () => [
              MovieRecommendationsLoading(),
              MovieRecommendationsHasData([testMovie])
            ],
        wait: Duration(milliseconds: 100),
        verify: (bloc) => verify(() => usecase.execute(testId)));

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'emits [Loading, Error] when OnFetchMovieRecommendations is added and error.',
        build: () {
          when(() => usecase.execute(testId))
              .thenAnswer((_) async => Left(ServerFailure('testError')));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendations(testId)),
        expect: () => [
              MovieRecommendationsLoading(),
              MovieRecommendationsError('testError')
            ],
        wait: Duration(milliseconds: 100),
        verify: (bloc) => verify(() => usecase.execute(testId)));
  });
}
