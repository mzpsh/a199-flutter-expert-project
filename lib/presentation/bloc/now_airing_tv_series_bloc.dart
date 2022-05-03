import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'now_airing_tv_series_event.dart';
part 'now_airing_tv_series_state.dart';

class NowAiringTvSeriesBloc
    extends Bloc<NowAiringTvSeriesEvent, NowAiringTvSeriesState> {
  final GetNowAiringTVSeries getNowAiringTVSeries;
  NowAiringTvSeriesBloc(this.getNowAiringTVSeries)
      : super(NowAiringTvSeriesLoading()) {
    on<OnFetchNowAiringTvSeries>((event, emit) async {
      emit(NowAiringTvSeriesLoading());

      final result = await getNowAiringTVSeries.execute();

      result.fold((failure) {
        emit(NowAiringTvSeriesError(failure.message));
      }, (data) {
        emit(NowAiringTvSeriesHasData(data));
      });
    });
  }
}
