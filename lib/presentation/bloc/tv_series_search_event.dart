part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTvSeriesSearch extends TvSeriesSearchEvent {
  final String query;
  OnQueryChangedTvSeriesSearch(this.query);

  @override
  List<Object> get props => [query];
}

class OnQueryChangedTvSeriesReset extends TvSeriesSearchEvent {}
