import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TVSeriesDetailStore extends StreamStore {
  final GetTVSeriesDetail getTVSeriesDetail;
  TVSeriesDetailStore({required this.getTVSeriesDetail}) : super([]);

  @override
  void initStore() async {
    super.initStore();
  }

  void fetchTVSeriesDetail(int id) async {
    setLoading(true, force: true);
    final result = await this.getTVSeriesDetail.execute(id);
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
