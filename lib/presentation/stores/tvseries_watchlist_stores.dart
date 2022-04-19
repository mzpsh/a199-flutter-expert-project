import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesWatchlistStore extends StreamStore<Exception, List<TVSeries>> {
  final TVSeriesRepository repository;
  TVSeriesWatchlistStore({required this.repository}) : super(<TVSeries>[]);

  @override
  void initStore() {
    _initWatchlist();
    super.initStore();
  }

  void _initWatchlist() async {
    var writtenWatchlist = await repository.readWatchlistTVSeries();
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
    await repository.writeWatchlistTVSeries(state);
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
