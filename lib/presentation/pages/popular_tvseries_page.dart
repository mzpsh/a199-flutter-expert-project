import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tvseries';
  PopularTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // popularTVSeriesListStores.fetchPopularTVSeries();
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
        builder: (context, state) {
          if (state is PopularTvSeriesHasData) {
            return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) =>
                    TVSeriesCard(state.result[index]));
          } else if (state is PopularTvSeriesLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
