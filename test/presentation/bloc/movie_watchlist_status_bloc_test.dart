import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late GetWatchListStatus getWatchListStatus;
  late SaveWatchlist saveWatchlist;
  late RemoveWatchlist removeWatchlist;
  late MovieWatchlistStatusBloc bloc;
  int testId = testMovieDetail.id;

  setUp(() {
    getWatchListStatus = MockGetWatchListStatus();
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    bloc = MovieWatchlistStatusBloc(
        getWatchListStatus: getWatchListStatus,
        saveWatchlist: saveWatchlist,
        removeWatchlist: removeWatchlist);
  });
  group('MovieWatchlistStatusBloc', () {
    test('initial state should be empty', () {
      expect(bloc.state, MovieWatchlistStatusEmpty());
    });

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emits [Loading, IsIn] when OnLoadMovieWatchlistStatus is added.',
      build: () {
        when(() => getWatchListStatus.execute(testId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadMovieWatchlistStatus(testId)),
      wait: Duration(milliseconds: 100),
      expect: () =>
          [MovieWatchlistStatusLoading(), MovieWatchlistStatusIsIn(true)],
      verify: (bloc) => verify(() => getWatchListStatus.execute(testId)),
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emits [Loading, IsIn] when OnAddMovieWatchlistStatus is added.',
      build: () {
        when(() => getWatchListStatus.execute(testId))
            .thenAnswer((_) async => true);
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('testMessage'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnAddMovieWatchlistStatus(testMovieDetail)),
      wait: Duration(milliseconds: 1000),
      expect: () =>
          [MovieWatchlistStatusLoading(), MovieWatchlistStatusIsIn(true)],
      verify: (bloc) => verify(() => saveWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emits [Loading, Error] when OnAddMovieWatchlistStatus is added and error.',
      build: () {
        when(() => getWatchListStatus.execute(testId))
            .thenAnswer((_) async => true);
        when(() => saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('testMessage')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnAddMovieWatchlistStatus(testMovieDetail)),
      wait: Duration(milliseconds: 1000),
      expect: () => [
        MovieWatchlistStatusLoading(),
        MovieWatchlistStatusError('testMessage')
      ],
      verify: (bloc) => verify(() => saveWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emits [Loading, IsIn] when OnRemoveMovieWatchlistStatus is added.',
      build: () {
        when(() => getWatchListStatus.execute(testId))
            .thenAnswer((_) async => false);
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('testMessage'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveMovieWatchlistStatus(testMovieDetail)),
      wait: Duration(milliseconds: 1000),
      expect: () =>
          [MovieWatchlistStatusLoading(), MovieWatchlistStatusIsIn(false)],
      verify: (bloc) => verify(() => removeWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'emits [Loading, Error] when OnRemoveMovieWatchlistStatus is added and error.',
      build: () {
        when(() => getWatchListStatus.execute(testId))
            .thenAnswer((_) async => false);
        when(() => removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('testMessage')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveMovieWatchlistStatus(testMovieDetail)),
      wait: Duration(milliseconds: 1000),
      expect: () => [
        MovieWatchlistStatusLoading(),
        MovieWatchlistStatusError('testMessage')
      ],
      verify: (bloc) => verify(() => removeWatchlist.execute(testMovieDetail)),
    );
  });
}
