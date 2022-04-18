import 'package:flutter/material.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tvseries';
  const SearchTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search TV Series')),
    );
  }
}
