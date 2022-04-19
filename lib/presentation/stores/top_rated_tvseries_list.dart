import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TopRatedTVSeriesListStores extends StreamStore {
  final GetTopRatedTVSeries getTopRatedTVSeries;
  TopRatedTVSeriesListStores({required this.getTopRatedTVSeries}) : super([]);

  @override
  void initStore() async {
    super.initStore();
    this.fetchPopularTVSeries();
  }

  void fetchPopularTVSeries() async {
    setLoading(true, force: true);
    final result = await this.getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        setError(failure.message, force: true);
      },
      (tvSeriesData) {
        update(tvSeriesData, force: true);
      },
    );
  }
}
