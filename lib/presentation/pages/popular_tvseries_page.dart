import 'package:flutter/material.dart';

class PopularTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tvseries';
  const PopularTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
    );
  }
}
