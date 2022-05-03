import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/tvseries_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvseries';

  WatchlistTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTVSeriesPage> createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesWatchlistBloc>().add(OnLoadTVSeriesWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvSeriesWatchlistBloc>().add(OnLoadTVSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TV Series Watchlist')),
      body: BlocBuilder<TvSeriesWatchlistBloc, TVSeriesWatchlistState>(
        builder: (context, state) {
          if (state is TVSeriesWatchlistHasData) {
            if (state.result.isEmpty) {
              return Center(child: Text('No watchlist'));
            }
            return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) =>
                    TVSeriesCard(state.result[index]));
          } else if (state is TVSeriesWatchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(child: Text('error'));
          }
        },
      ),
    );
  }
}
