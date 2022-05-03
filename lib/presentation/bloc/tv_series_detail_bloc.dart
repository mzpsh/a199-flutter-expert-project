import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;
  TVSeriesDetailBloc(this.getTVSeriesDetail) : super(TVSeriesDetailLoading()) {
    on<OnFetchTVSeriesDetail>((event, emit) async {
      emit(TVSeriesDetailLoading());

      final result = await getTVSeriesDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TVSeriesDetailError(failure.message));
        },
        (data) {
          emit(TVSeriesDetailHasData(data));
        },
      );
    });
  }
}
