import 'package:flutter/material.dart';

class WatchlistTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-tvseries';

  const WatchlistTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TV Series Watchlist')),
    );
  }
}
