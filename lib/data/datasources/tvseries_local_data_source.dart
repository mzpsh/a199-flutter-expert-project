import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tvseries_table.dart';

// abstract class TVSeriesLocalDataSource {
//   // Future<String> insertWatchlist(TVSeriesTable movie);
//   // Future<String> removeWatchlist(TVSeriesTable movie);
//   // Future<TVSeriesTable?> getMovieById(int id);
//   // Future<List<TVSeriesTable>> getWatchlistMovies();
//   Future<void> cacheNowAiringTVSeries(List<TVSeriesTable> movies);
//   // Future<List<TVSeriesTable>> getCachedNowPlayingMovies();
// }

// class TVSeriesLocalDataSourcImpl implements TVSeriesLocalDataSource {
//   final DatabaseHelper databaseHelper;
//   TVSeriesLocalDataSourcImpl({required this.databaseHelper});

//   @override
//   Future<void> cacheNowAiringTVSeries(List<TVSeriesTable> tvSeriesList) async {
//     await databaseHelper.clearCache('now airing');
//     await databaseHelper.insertCacheTransactionTVSeries(
//         tvSeriesList, 'now airing');
//   }
// }
