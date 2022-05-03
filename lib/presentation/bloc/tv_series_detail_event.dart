part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTVSeriesDetail extends TVSeriesDetailEvent {
  final int id;

  OnFetchTVSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}
