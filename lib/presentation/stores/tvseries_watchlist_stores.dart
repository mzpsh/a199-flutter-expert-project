import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesWatchlistStore extends StreamStore<Exception, List<TVSeries>> {
  TVSeriesWatchlistStore() : super(<TVSeries>[]);

  @override
  void initStore() {
    // TODO: implement initStore
    super.initStore();
  }

  void addToWatchlist(TVSeries tvSeries) {
    setLoading(true, force: true);
    state.add(tvSeries);
    print(state);
    update(state, force: true);
  }
}
