import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/sembast_database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/read_watchlist_tvseries.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/domain/usecases/write_watchlist_tvseries.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/stores/now_airing_tvseries_list_store.dart';
import 'package:ditonton/presentation/stores/top_rated_tvseries_list_store.dart';
import 'package:ditonton/presentation/stores/tvseries_detail_store.dart';
import 'package:ditonton/presentation/stores/tvseries_recommendations_store.dart';
import 'package:ditonton/presentation/stores/tvseries_search_store.dart';
import 'package:ditonton/presentation/stores/tvseries_watchlist_store.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

import 'presentation/stores/popular_tvseries_list_store.dart';

final locator = GetIt.instance;

void init() async {
  // database helper
  Get.put(StoreRef.main());
  final db = SembastDatabaseHelper();

  // tv series network info
  Get.put(DataConnectionChecker());
  Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()));

  // tv series external
  Get.put<http.Client>(http.Client());

  // tv series data source
  Get.put<TVSeriesRemoteDataSource>(TVSeriesRemoteDataSourceImpl(
    client: Get.find(),
  ));
  Get.put<TVSeriesLocalDataSource>(TVSeriesLocalDataSourcImpl(
    db: await db.database,
    storeRef: StoreRef.main(),
  ));

  // tv series repository
  Get.put<TVSeriesRepository>(TVSeriesRepositoryImpl(
    remoteDataSource: Get.find(),
    // networkInfo: Get.find(),
    localDataSource: Get.find(),
  ));

  // tvseries usecases
  Get.put(GetNowAiringTVSeries(Get.find()));
  Get.put(GetPopularTVSeries(Get.find()));
  Get.put(GetTopRatedTVSeries(Get.find()));
  Get.put(GetTVSeriesDetail(Get.find()));
  Get.put(ReadWatchlistTVSeries(Get.find()));
  Get.put(WriteWatchlistTVSeries(Get.find()));
  Get.put(SearchTVSeries(Get.find()));
  Get.put(GetTVSeriesRecommendations(Get.find()));

  // tvseries stores
  Get.put(NowAiringTVSeriesListStores(getNowAiringTVSeries: Get.find()));
  Get.put(PopularTVSeriesListStores(getPopularTVSeries: Get.find()));
  Get.put(TopRatedTVSeriesListStores(getTopRatedTVSeries: Get.find()));
  Get.put(TVSeriesDetailStore(getTVSeriesDetail: Get.find()));
  Get.put(TVSeriesWatchlistStore(
    writeWatchlistTVSeries: Get.find(),
    readWatchlistTVSeries: Get.find(),
  ));
  Get.put(TVSeriesSearchStore(searchTVSeries: Get.find()));
  Get.put(TVSeriesRecommendationsStore(getTVSeriesRecommendations: Get.find()));

  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
