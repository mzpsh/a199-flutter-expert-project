import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail usecase;
  late MovieDetailBloc bloc;
  int testId = 69;

  setUp(() {
    usecase = MockGetMovieDetail();
    bloc = MovieDetailBloc(usecase);
  });
  group('MovieDetailBloc', () {
    test('initial state should be empty.', () {
      expect(bloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, HasData] when OnFetchMovieDetail is added.',
      build: () {
        when(() => usecase.execute(testId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(testId)),
      wait: Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
      verify: (bloc) => verify(() => usecase.execute(testId)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when OnFetchMovieDetail is added and error.',
      build: () {
        when(() => usecase.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('testError')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(testId)),
      wait: Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), MovieDetailError('testError')],
      verify: (bloc) => verify(() => usecase.execute(testId)),
    );
  });
}
