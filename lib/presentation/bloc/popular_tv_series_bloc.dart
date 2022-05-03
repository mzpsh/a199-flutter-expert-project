import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTVSeries getPopularTVSeries;
  PopularTvSeriesBloc(this.getPopularTVSeries)
      : super(PopularTvSeriesLoading()) {
    on<PopularTvSeriesEvent>((event, emit) async {
      emit(PopularTvSeriesLoading());

      final result = await getPopularTVSeries.execute();

      result.fold(
        (failure) => emit(PopularTvSeriesError(failure.message)),
        (data) => emit(PopularTvSeriesHasData(data)),
      );
    });
  }
}
