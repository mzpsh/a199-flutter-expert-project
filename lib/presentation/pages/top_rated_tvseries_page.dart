import 'package:flutter/material.dart';

class TopRatedTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  const TopRatedTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated TV Series')),
    );
  }
}
