part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusEmpty extends MovieWatchlistStatusState {}

class MovieWatchlistStatusLoading extends MovieWatchlistStatusState {}

class MovieWatchlistStatusError extends MovieWatchlistStatusState {
  final String message;

  MovieWatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusIsIn extends MovieWatchlistStatusState {
  final bool isIn;

  MovieWatchlistStatusIsIn(this.isIn);

  @override
  List<Object> get props => [isIn];
}
