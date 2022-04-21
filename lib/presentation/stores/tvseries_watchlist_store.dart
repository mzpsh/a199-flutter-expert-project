import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/write_watchlist_tvseries.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesWatchlistStore extends StreamStore<Exception, List<TVSeries>> {
  final ReadWatchlistTVSeries readWatchlistTVSeries;
  final WriteWatchlistTVSeries writeWatchlistTVSeries;
  TVSeriesWatchlistStore(
      {required this.readWatchlistTVSeries,
      required this.writeWatchlistTVSeries})
      : super(<TVSeries>[]);

  @override
  void initStore() {
    _initWatchlist();
    super.initStore();
  }

  void _initWatchlist() async {
    var writtenWatchlist = await readWatchlistTVSeries.execute();
    if (writtenWatchlist.isNotEmpty) {
      update(writtenWatchlist);
    }
  }

  void toggleToWatchlist(TVSeries tvSeries) async {
    setLoading(true, force: true);

    if (checkIfInWatchlist(tvSeries)) {
      state.remove(tvSeries);
    } else {
      state.add(tvSeries);
    }
    await writeWatchlistTVSeries.execute(state);
    update(state, force: true);
  }

  bool checkIfInWatchlist(TVSeries tvSeriesToCheck) {
    for (TVSeries tvSeries in state) {
      if (tvSeries.id == tvSeriesToCheck.id) {
        return true;
      }
    }
    return false;
  }
}
