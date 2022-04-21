import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/stores/tvseries_search_store.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tvseries';
  final TVSeriesSearchStore tvSeriesSearchStore = Get.find();
  SearchTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                tvSeriesSearchStore.findTVSeries(query);
              },
              decoration: InputDecoration(
                hintText: 'Search tv series name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Expanded(
              child: ScopedBuilder(
                store: tvSeriesSearchStore,
                onState: (context, state) {
                  var list = state as List<TVSeries>;
                  if (list.isEmpty) {
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          TVSeriesCard(list[index]),
                    );
                  }
                },
                onError: (context, error) => Center(child: Text('$error')),
                onLoading: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
