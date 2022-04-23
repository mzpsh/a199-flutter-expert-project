import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PopularTVSeriesListStores extends StreamStore {
  final GetPopularTVSeries getPopularTVSeries;
  PopularTVSeriesListStores({required this.getPopularTVSeries}) : super([]);

  @override
  void initStore() async {
    super.initStore();
    this.fetchPopularTVSeries();
  }

  Future<void> fetchPopularTVSeries() async {
    setLoading(true, force: true);
    final result = await this.getPopularTVSeries.execute();
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
