part of 'tv_series_watchlist_bloc.dart';

abstract class TVSeriesWatchlistEvent extends Equatable {
  const TVSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnLoadTVSeriesWatchlist extends TVSeriesWatchlistEvent {}
