part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  OnAddMovieWatchlistStatus(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  OnRemoveMovieWatchlistStatus(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadMovieWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;
  OnLoadMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
