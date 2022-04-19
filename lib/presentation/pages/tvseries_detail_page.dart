import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/presentation/pages/tvseries_page.dart';
import 'package:ditonton/presentation/stores/tvseries_detail_store.dart';
import 'package:ditonton/presentation/stores/tvseries_recommendations_store.dart';
import 'package:ditonton/presentation/stores/tvseries_watchlist_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class TVSeriesDetailPage extends StatelessWidget {
  static const routeName = '/detail-tv';
  final TVSeriesDetailStore tvSeriesDetailStore = Get.find();
  final int id;

  TVSeriesDetailPage({this.id = 102045, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tvSeriesDetailStore.fetchTVSeriesDetail(id);
    return Scaffold(
      body: ScopedBuilder(
        store: tvSeriesDetailStore,
        onState: (context, state) =>
            SafeArea(child: DetailContentTV(state as TVSeriesDetail)),
        onError: (context, error) => Center(child: Text('error')),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class DetailContentTV extends StatelessWidget {
  final TVSeriesDetail tvSeriesDetail;
  final TVSeriesWatchlistStore tVSeriesWatchlistStore = Get.find();
  final TVSeriesRecommendationsStore tvSeriesRecommendationsStore = Get.find();

  // final List<Movie> recommendations;
  // final bool isAddedWatchlist;

  // DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);
  DetailContentTV(this.tvSeriesDetail);

  @override
  Widget build(BuildContext context) {
    tvSeriesRecommendationsStore.getRecommendations(tvSeriesDetail.id);
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          // coverage:ignore-start
          errorWidget: (context, url, error) => Icon(Icons.error),
          // coverage:ignore-end
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                tVSeriesWatchlistStore.toggleToWatchlist(
                                    tvSeriesDetail.toTVSeries());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScopedBuilder(
                                    store: tVSeriesWatchlistStore,
                                    onState: (context, state) =>
                                        tVSeriesWatchlistStore
                                                .checkIfInWatchlist(
                                                    tvSeriesDetail.toTVSeries())
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                    onError: (context, error) =>
                                        Center(child: Text('error')),
                                    onLoading: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    'Seasons: ${tvSeriesDetail.numberOfSeasons}  '),
                                Text(
                                    'Episode: ${tvSeriesDetail.numberOfEpisodes}'),
                              ],
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(
                                    '${(tvSeriesDetail.voteAverage / 2).toStringAsFixed(1)}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            ScopedBuilder(
                              store: tvSeriesRecommendationsStore,
                              onState: (context, state) =>
                                  TVSeriesList(state as List<TVSeries>),
                              onError: (context, error) =>
                                  Center(child: Text('error')),
                              onLoading: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
