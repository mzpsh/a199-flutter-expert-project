part of 'tv_series_watchlist_bloc.dart';

abstract class TVSeriesWatchlistState extends Equatable {
  const TVSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TVSeriesWatchlistLoading extends TVSeriesWatchlistState {}

class TVSeriesWatchlistError extends TVSeriesWatchlistState {
  final String message;
  TVSeriesWatchlistError(this.message);
}

class TVSeriesWatchlistHasData extends TVSeriesWatchlistState {
  final List<TVSeries> result;

  TVSeriesWatchlistHasData(this.result);
}
