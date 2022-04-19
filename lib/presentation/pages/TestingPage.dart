import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/presentation/stores/now_airing_tvseries_list_store.dart';
import 'package:ditonton/presentation/stores/tvseries_detail_stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class TestingPage extends StatelessWidget {
  static const routeName = '/testing';
  TestingPage({Key? key}) : super(key: key);

  final TVSeriesDetailStore store = Get.find();
  @override
  Widget build(BuildContext context) {
    store.fetchTVSeriesDetail(80986);
    return Scaffold(
      body: ScopedBuilder(
        store: store,
        onState: (context, state) => Center(child: Text('$state')),
        onError: (context, error) => Center(child: Text('error')),
        onLoading: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
