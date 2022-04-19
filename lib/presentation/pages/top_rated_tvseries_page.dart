import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/stores/top_rated_tvseries_list.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class TopRatedTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  TopRatedTVSeriesPage({Key? key}) : super(key: key);
  final TopRatedTVSeriesListStores topRatedTVSeriesListStores = Get.find();

  @override
  Widget build(BuildContext context) {
    // popularTVSeriesListStores.fetchPopularTVSeries();
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: ScopedBuilder(
        store: topRatedTVSeriesListStores,
        onState: (context, state) {
          final tvSeriesList = state as List<TVSeries>;
          return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) =>
                  TVSeriesCard(tvSeriesList[index]));
        },
        onError: (context, error) => Center(child: Text('error')),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
