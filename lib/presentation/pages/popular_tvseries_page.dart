import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/stores/popular_tvseries_list_store.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class PopularTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tvseries';
  PopularTVSeriesPage({Key? key}) : super(key: key);

  final PopularTVSeriesListStores popularTVSeriesListStores = Get.find();

  @override
  Widget build(BuildContext context) {
    // popularTVSeriesListStores.fetchPopularTVSeries();
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: ScopedBuilder(
        store: popularTVSeriesListStores,
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
