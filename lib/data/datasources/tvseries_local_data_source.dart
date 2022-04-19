import 'dart:convert';

import 'package:ditonton/data/datasources/db/sembast_database_helper.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:sembast/sembast.dart';

abstract class TVSeriesLocalDataSource {
  // Future<String> insertWatchlist(TVSeriesTable movie);
  // Future<String> removeWatchlist(TVSeriesTable movie);
  // Future<TVSeriesTable?> getMovieById(int id);
  // Future<List> getWatchlistTVSeries();
  Future<bool> writeWatchlistTVSeries(List<TVSeriesModel> tvSeriesModelList);
  Future<List<TVSeriesModel>> readWatchlistTVSeries();
  // Future<void> cacheNowAiringTVSeries(List<TVSeriesTable> movies);
  // Future<List<TVSeriesTable>> getCachedNowPlayingMovies();
}

class TVSeriesLocalDataSourcImpl implements TVSeriesLocalDataSource {
//   final DatabaseHelper databaseHelper;
//   TVSeriesLocalDataSourcImpl({required this.databaseHelper});

//   @override
//   Future<void> cacheNowAiringTVSeries(List<TVSeriesTable> tvSeriesList) async {
//     await databaseHelper.clearCache('now airing');
//     await databaseHelper.insertCacheTransactionTVSeries(
//         tvSeriesList, 'now airing');
//   }

  @override
  Future<bool> writeWatchlistTVSeries(
      List<TVSeriesModel> tvSeriesModelList) async {
    var db = await SembastDatabaseHelper.getDatabase();
    var tvWatchlistRecord = StoreRef.main().record('tvWatchlist');
    List json = [];
    for (var element in tvSeriesModelList) {
      json.add(element.toJson());
    }

    var jsonRaw = jsonEncode(json);
    try {
      await tvWatchlistRecord.put(db, jsonRaw, merge: false);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<TVSeriesModel>> readWatchlistTVSeries() async {
    var db = await SembastDatabaseHelper.getDatabase();
    var tvWatchlistRecord = StoreRef.main().record('tvWatchlist');
    var list = <TVSeriesModel>[];

    try {
      var jsonRaw = await tvWatchlistRecord.get(db);
      List json = jsonDecode(jsonRaw);

      for (var element in json) {
        list.add(TVSeriesModel.fromJson(element));
      }
      return list;
    } catch (e) {
      return list;
    }
  }
}
