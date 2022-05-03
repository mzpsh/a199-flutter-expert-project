import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:sembast/sembast.dart';

abstract class TVSeriesLocalDataSource {
  Future<bool> writeWatchlistTVSeries(List<TVSeriesModel> tvSeriesModelList);
  Future<List<TVSeriesModel>> readWatchlistTVSeries();
}

class TVSeriesLocalDataSourcImpl implements TVSeriesLocalDataSource {
  final Database db;
  final StoreRef storeRef;

  TVSeriesLocalDataSourcImpl({
    required this.db,
    required this.storeRef,
  });

  @override
  Future<bool> writeWatchlistTVSeries(
      List<TVSeriesModel> tvSeriesModelList) async {
    var tvWatchlistRecord = storeRef.record('tvWatchlist');
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
    var tvWatchlistRecord = storeRef.record('tvWatchlist');
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
