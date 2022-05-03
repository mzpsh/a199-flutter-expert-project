import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/search_tvseries_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvseries_page.dart';
import 'package:ditonton/presentation/pages/tvseries_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/tvseries';
  TVSeriesPage({Key? key}) : super(key: key);

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
    context.read<NowAiringTvSeriesBloc>().add(OnFetchNowAiringTvSeries());
    context.read<PopularTvSeriesBloc>().add(OnFetchPopularTvSeries());
    context.read<TopRatedTvSeriesBloc>().add(OnFetchTopRatedTvSeries());
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
            BlocBuilder<NowAiringTvSeriesBloc, NowAiringTvSeriesState>(
                builder: (context, state) {
              if (state is NowAiringTvSeriesHasData) {
                return TVSeriesList(state.result);
              } else if (state is NowAiringTvSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('Error'));
              }
            }),
            _buildSubHeading(
              title: 'Popular TV Series',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
              if (state is PopularTvSeriesHasData) {
                return TVSeriesList(state.result);
              } else if (state is PopularTvSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('Error'));
              }
            }),
            _buildSubHeading(
              title: 'Top Rated TV Series',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, state) {
              if (state is TopRatedTvSeriesHasData) {
                return TVSeriesList(state.result);
              } else if (state is TopRatedTvSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('Error'));
              }
            }),
          ]),
        ),
      ),
    );
  }
}

/// Submission 1108758
/// Fix onTap method
/// ignore: must_be_immutable
class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeriesList;
  bool isFromRecommendation;

  TVSeriesList(this.tvSeriesList, {this.isFromRecommendation = false});

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
              onTap: isFromRecommendation
                  ? () {
                      Navigator.pushReplacementNamed(
                        context,
                        TVSeriesDetailPage.routeName,
                        arguments: movie.id,
                      );
                    }
                  : () {
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
