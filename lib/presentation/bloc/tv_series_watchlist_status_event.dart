part of 'tv_series_watchlist_status_bloc.dart';

abstract class TvSeriesWatchlistStatusEvent extends Equatable {
  const TvSeriesWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnCheckTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final TVSeries tvSeries;
  OnCheckTvSeriesWatchlistStatus(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnToggleTvSeriesWatchlistStatus extends TvSeriesWatchlistStatusEvent {
  final TVSeries tvSeries;
  OnToggleTvSeriesWatchlistStatus(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
