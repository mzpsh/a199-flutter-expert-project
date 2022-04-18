import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_airing_airing_tvseries.dart';
import 'package:get/get.dart';

class TVSeriesListController extends GetxController {
  var nowAiringState = RequestState.Loading.obs;
  var popularState = RequestState.Loading.obs;
  var topRatedState = RequestState.Loading.obs;

  final GetNowAiringTVSeries getNowAiringTVSeries;
  TVSeriesListController({
    required this.getNowAiringTVSeries,
  });

  @override
  void onInit() {
    super.onInit();

    this.getNowAiringTVSeries.execute();
  }
}
