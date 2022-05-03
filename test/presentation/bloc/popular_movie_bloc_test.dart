import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies usecase;
  late PopularMovieBloc bloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    bloc = PopularMovieBloc(usecase);
  });

  group('PopularMovieBloc', () {
    test('initial state should be empty.', () {
      expect(bloc.state, PopularMovieEmpty());
    });

    blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [Loading, HasData] when OnFetchPopularMovie is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData([testMovie])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [Loading, Error] when OnFetchPopularMovie is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Left(ServerFailure('testError')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [PopularMovieLoading(), PopularMovieError('testError')],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
