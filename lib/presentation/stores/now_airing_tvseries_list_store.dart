import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
import 'package:flutter_triple/flutter_triple.dart';

class NowAiringTVSeriesListStores extends StreamStore {
  final GetNowAiringTVSeries getNowAiringTVSeries;
  NowAiringTVSeriesListStores({required this.getNowAiringTVSeries}) : super([]);

  @override
  void initStore() async {
    super.initStore();
    this.fetchNowAiringTVSeries();
  }

  Future<void> fetchNowAiringTVSeries() async {
    setLoading(true, force: true);
    final result = await this.getNowAiringTVSeries.execute();
    result.fold(
      (failure) {
        print(failure);
        setError(failure.message, force: true);
      },
      (tvSeriesData) {
        update(tvSeriesData, force: true);
      },
    );
  }
}
