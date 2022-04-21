import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesSearchStore extends StreamStore<String, List<TVSeries>> {
  final SearchTVSeries searchTVSeries;
  TVSeriesSearchStore({required this.searchTVSeries}) : super(<TVSeries>[]);

  @override
  void initStore() async {
    super.initStore();
  }

  void findTVSeries(String query) async {
    setLoading(true, force: true);
    final result = await this.searchTVSeries.execute(query);
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
