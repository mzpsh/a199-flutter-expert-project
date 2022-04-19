import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/stores/tvseries_watchlist_stores.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class WatchlistTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-tvseries';

  WatchlistTVSeriesPage({Key? key}) : super(key: key);
  final TVSeriesWatchlistStore tVSeriesWatchlistStore = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TV Series Watchlist')),
      body: ScopedBuilder(
        store: tVSeriesWatchlistStore,
        onState: (context, state) {
          final tvSeriesList = state as List<TVSeries>;
          if (tvSeriesList.isEmpty) {
            return Center(child: Text('No watchlist'));
          }
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
