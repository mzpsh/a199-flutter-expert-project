part of 'now_airing_tv_series_bloc.dart';

abstract class NowAiringTvSeriesState extends Equatable {
  const NowAiringTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowAiringTvSeriesLoading extends NowAiringTvSeriesState {}

class NowAiringTvSeriesError extends NowAiringTvSeriesState {
  final String message;
  NowAiringTvSeriesError(this.message);
}

class NowAiringTvSeriesHasData extends NowAiringTvSeriesState {
  final List<TVSeries> result;
  NowAiringTvSeriesHasData(this.result);
}
