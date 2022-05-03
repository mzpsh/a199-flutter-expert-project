part of 'now_airing_tv_series_bloc.dart';

abstract class NowAiringTvSeriesEvent extends Equatable {
  const NowAiringTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowAiringTvSeries extends NowAiringTvSeriesEvent {}
