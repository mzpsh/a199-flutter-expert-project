import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late MockGetWatchlistMovies usecase;
  late WatchlistMovieBloc bloc;

  setUp(() {
    usecase = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(usecase);
  });
  group('WatchlistMovieBLoc', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, HasData] when OnFetchWatchlistMovie is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: Duration(milliseconds: 100),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData([testMovie])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Error] when OnFetchWatchlistMovie is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('testError')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: Duration(milliseconds: 100),
      expect: () => [WatchlistMovieLoading(), WatchlistMovieError('testError')],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
