import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistStatusBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieWatchlistStatusEmpty()) {
    on<OnLoadMovieWatchlistStatus>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await getWatchListStatus.execute(event.id);

      emit(MovieWatchlistStatusIsIn(result));
    });

    on<OnAddMovieWatchlistStatus>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await saveWatchlist.execute(event.movieDetail);
      final isIn = await getWatchListStatus.execute(event.movieDetail.id);

      result.fold(
        (failure) {
          emit(MovieWatchlistStatusError(failure.message));
        },
        (data) async {
          emit(MovieWatchlistStatusIsIn(isIn));
        },
      );
    });

    on<OnRemoveMovieWatchlistStatus>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await removeWatchlist.execute(event.movieDetail);
      final isIn = await getWatchListStatus.execute(event.movieDetail.id);

      result.fold(
        (failure) {
          emit(MovieWatchlistStatusError(failure.message));
        },
        (data) {
          emit(MovieWatchlistStatusIsIn(isIn));
        },
      );
    });
  }
}
