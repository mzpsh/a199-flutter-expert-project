import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:get/get.dart';

class TopRatedTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  TopRatedTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // popularTVSeriesListStores.fetchPopularTVSeries();
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
        builder: (context, state) {
          if (state is TopRatedTvSeriesHasData) {
            return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) =>
                    TVSeriesCard(state.result[index]));
          } else if (state is TopRatedTvSeriesLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
