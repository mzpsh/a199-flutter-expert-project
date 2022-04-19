import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/pages/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/search_tvseries_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries_detail_page.dart';
import 'package:ditonton/presentation/stores/now_airing_tvseries_list_store.dart';
import 'package:ditonton/presentation/stores/popular_tvseries_list_store.dart';
import 'package:ditonton/presentation/stores/top_rated_tvseries_list.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class TVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/tvseries';
  TVSeriesPage({Key? key}) : super(key: key);
  final NowAiringTVSeriesListStores nowAiringTVSeriesListStores = Get.find();
  final PopularTVSeriesListStores popularTVSeriesListStores = Get.find();
  final TopRatedTVSeriesListStores topRatedTVSeriesListStores = Get.find();

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Currently Airing',
              style: kHeading6,
            ),
            ScopedBuilder(
              store: nowAiringTVSeriesListStores,
              onState: (context, state) =>
                  TVSeriesList(state as List<TVSeries>),
              onError: (context, error) => Center(child: Text('$error')),
              onLoading: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            _buildSubHeading(
              title: 'Popular TV Series',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
            ),
            ScopedBuilder(
              store: popularTVSeriesListStores,
              onState: (context, state) =>
                  TVSeriesList(state as List<TVSeries>),
              onError: (context, error) => Center(child: Text('$error')),
              onLoading: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            _buildSubHeading(
              title: 'Top Rated TV Series',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVSeriesPage.ROUTE_NAME),
            ),
            ScopedBuilder(
              store: topRatedTVSeriesListStores,
              onState: (context, state) =>
                  TVSeriesList(state as List<TVSeries>),
              onError: (context, error) => Center(child: Text('$error')),
              onLoading: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeriesList;

  TVSeriesList(this.tvSeriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
