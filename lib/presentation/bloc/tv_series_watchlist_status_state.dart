part of 'tv_series_watchlist_status_bloc.dart';

abstract class TvSeriesWatchlistStatusState extends Equatable {
  const TvSeriesWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistStatusLoading extends TvSeriesWatchlistStatusState {}

class TvSeriesWatchlistStatusError extends TvSeriesWatchlistStatusState {
  final String message;
  TvSeriesWatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistStatusIsIn extends TvSeriesWatchlistStatusState {
  final bool isIn;
  TvSeriesWatchlistStatusIsIn(this.isIn);

  @override
  List<Object> get props => [isIn];
}
