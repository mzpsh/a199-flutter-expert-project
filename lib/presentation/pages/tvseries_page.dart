import 'package:ditonton/presentation/pages/popular_tvseries_page.dart';
import 'package:ditonton/presentation/pages/search_tvseries_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/common/constants.dart';

class TVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/tvseries';
  const TVSeriesPage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Currently Airing',
            style: kHeading6,
          ),
          _buildSubHeading(
            title: 'Popular TV Series',
            onTap: () =>
                Navigator.pushNamed(context, PopularTVSeriesPage.ROUTE_NAME),
          ),
          _buildSubHeading(
            title: 'Top Rated TV Series',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedTVSeriesPage.ROUTE_NAME),
          ),
        ]),
      ),
    );
  }
}
