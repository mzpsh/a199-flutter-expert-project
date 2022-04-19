import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/pages/search_tvseries_page.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesRecommendationsStore extends StreamStore<String, List<TVSeries>> {
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  TVSeriesRecommendationsStore({required this.getTVSeriesRecommendations})
      : super(<TVSeries>[]);

  @override
  void initStore() async {
    super.initStore();
  }

  void getRecommendations(int id) async {
    setLoading(true, force: true);
    final result = await this.getTVSeriesRecommendations.execute(id);
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
