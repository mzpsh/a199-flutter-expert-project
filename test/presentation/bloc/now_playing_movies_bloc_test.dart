import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  late MockGetNowPlayingMovies usecase;
  late NowPlayingMoviesBloc bloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    bloc = NowPlayingMoviesBloc(usecase);
  });

  group('NowPlayingMoviesBloc', () {
    test('should be empty when initialized', () {
      expect(bloc.state, NowPlayingMoviesEmpty());
    });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'emits [Loading, HasData] when OnFetchNowPlayingMovies is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesHasData([testMovie])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'emits [Loading, Error] when OnFetchNowPlayingMovies is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Left(ServerFailure('testError')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () =>
          [NowPlayingMoviesLoading(), NowPlayingMoviesError('testError')],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
