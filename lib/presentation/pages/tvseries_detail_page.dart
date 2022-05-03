import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/pages/tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatelessWidget {
  static const routeName = '/detail-tv';
  final int id;

  TVSeriesDetailPage({this.id = 102045, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TVSeriesDetailBloc>().add(OnFetchTVSeriesDetail(this.id));
    return Scaffold(body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
      builder: (context, state) {
        if (state is TVSeriesDetailHasData) {
          return SafeArea(child: DetailContentTV(state.result));
        } else if (state is TVSeriesDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('error'));
        }
      },
    ));
  }
}

class DetailContentTV extends StatelessWidget {
  final TVSeriesDetail tvSeriesDetail;

  // final List<Movie> recommendations;
  // final bool isAddedWatchlist;

  // DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);
  DetailContentTV(this.tvSeriesDetail);

  @override
  Widget build(BuildContext context) {
    context
        .read<TvSeriesWatchlistStatusBloc>()
        .add(OnCheckTvSeriesWatchlistStatus(this.tvSeriesDetail.toTVSeries()));

    context
        .read<TvSeriesRecommendationsBloc>()
        .add(OnFetchTvSeriesRecommendation(this.tvSeriesDetail.id));
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
                                context
                                    .read<TvSeriesWatchlistStatusBloc>()
                                    .add(OnToggleTvSeriesWatchlistStatus(
                                      this.tvSeriesDetail.toTVSeries(),
                                    ));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlocBuilder<TvSeriesWatchlistStatusBloc,
                                          TvSeriesWatchlistStatusState>(
                                      builder: ((context, state) {
                                    if (state is TvSeriesWatchlistStatusIsIn) {
                                      return state.isIn
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add);
                                    } else if (state
                                        is TvSeriesWatchlistStatusLoading) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      return Center(child: Text('error'));
                                    }
                                  })),
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
                            BlocBuilder<TvSeriesRecommendationsBloc,
                                TvSeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationsHasData) {
                                  return TVSeriesList(
                                    state.result,
                                    isFromRecommendation: true,
                                  );
                                } else if (state
                                    is TvSeriesRecommendationsLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )
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
