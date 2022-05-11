import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTVSeries searchTVSeries;
  TvSeriesSearchBloc(this.searchTVSeries) : super(TvSeriesSearchEmpty()) {
    on<OnQueryChangedTvSeriesSearch>((event, emit) async {
      emit(TvSeriesSearchLoading());

      final result = await searchTVSeries.execute(event.query);

      result.fold(
        (failure) {
          emit(TvSeriesSearchError(failure.message));
        },
        (data) {
          emit(TvSeriesSearchHasData(data));
        },
      );
    });
    on<OnQueryChangedTvSeriesReset>((event, emit) async {
      emit(TvSeriesSearchEmpty());
    });
  }
}
