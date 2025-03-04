import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tvseries';
  SearchTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TvSeriesSearchBloc>().add(OnQueryChangedTvSeriesReset());
    return Scaffold(
      appBar: AppBar(title: Text('Search TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                print(query);
                context
                    .read<TvSeriesSearchBloc>()
                    .add(OnQueryChangedTvSeriesSearch(query));
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
              child: BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                builder: (context, state) {
                  if (state is TvSeriesSearchHasData) {
                    return ListView.builder(
                        itemCount: state.result.length,
                        itemBuilder: (context, index) =>
                            TVSeriesCard(state.result[index]));
                  } else if (state is TvSeriesSearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TvSeriesSearchEmpty) {
                    return Center(child: Text('Type the search term...'));
                  } else {
                    return Center(child: Text('Error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
