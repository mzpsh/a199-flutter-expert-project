import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/write_watchlist_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_status_event.dart';
part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusBloc
    extends Bloc<TvSeriesWatchlistStatusEvent, TvSeriesWatchlistStatusState> {
  final ReadWatchlistTVSeries readWatchlistTVSeries;
  final WriteWatchlistTVSeries writeWatchlistTVSeries;
  TvSeriesWatchlistStatusBloc({
    required this.readWatchlistTVSeries,
    required this.writeWatchlistTVSeries,
  }) : super(TvSeriesWatchlistStatusLoading()) {
    on<OnCheckTvSeriesWatchlistStatus>((event, emit) async {
      emit(TvSeriesWatchlistStatusLoading());
      final tvSeries = event.tvSeries;
      final list = await readWatchlistTVSeries.execute();

      // Submission 1122703 Fix
      bool inList = false;

      for (TVSeries tvInList in list) {
        if (tvSeries.id == tvInList.id) {
          inList = true;
        }
      }

      emit(TvSeriesWatchlistStatusIsIn(inList));
    });

    on<OnToggleTvSeriesWatchlistStatus>((event, emit) async {
      emit(TvSeriesWatchlistStatusLoading());

      final tvSeries = event.tvSeries;
      final list = await readWatchlistTVSeries.execute();

      final filteredList = list.map((element) {
        if (element.id == tvSeries.id) {
          return element;
        }
      });

      if (filteredList.length == 1) {
        list.remove(tvSeries);
        await writeWatchlistTVSeries.execute(list);
        emit(TvSeriesWatchlistStatusIsIn(false));
      } else {
        list.add(tvSeries);
        await writeWatchlistTVSeries.execute(list);
        emit(TvSeriesWatchlistStatusIsIn(true));
      }
    });
  }
}
