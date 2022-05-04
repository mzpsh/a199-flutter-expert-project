import 'dart:io';

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
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
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
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:sembast/sembast.dart';

final locator = GetIt.instance;

Future<IOClient> getGlobalContextedIoClient() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sslCert = await rootBundle.load('assets/certificates/certificate.cer');

  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;

  IOClient ioClient = IOClient(client);
  return ioClient;
}

/// Submission 1108243 Fix
/// Make the init asynchronous
Future<void> init() async {
  // SSL pinning
  final http.Client ioClient = await getGlobalContextedIoClient();

  // database helper
  Get.put(StoreRef.main());
  final dbHelper = SembastDatabaseHelper();
  final db = await dbHelper.database;

  // tv series network info
  Get.put(DataConnectionChecker());
  Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()));

  // tv series external
  Get.put<http.Client>(ioClient);

  // tv series data source
  Get.put<TVSeriesRemoteDataSource>(TVSeriesRemoteDataSourceImpl(
    client: Get.find(),
  ));
  Get.put<TVSeriesLocalDataSource>(TVSeriesLocalDataSourcImpl(
    db: db,
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

  // bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => MovieRecommendationsBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieWatchlistStatusBloc(
        getWatchListStatus: locator(),
        removeWatchlist: locator(),
        saveWatchlist: locator(),
      ));

  locator.registerLazySingleton(() => TVSeriesDetailBloc(Get.find()));
  locator.registerLazySingleton(() => TvSeriesWatchlistStatusBloc(
        readWatchlistTVSeries: Get.find(),
        writeWatchlistTVSeries: Get.find(),
      ));
  locator.registerLazySingleton(() => TvSeriesWatchlistBloc(Get.find()));
  locator.registerLazySingleton(() => TvSeriesSearchBloc(Get.find()));
  locator.registerLazySingleton(() => TvSeriesRecommendationsBloc(Get.find()));
  locator.registerLazySingleton(() => NowAiringTvSeriesBloc(Get.find()));
  locator.registerLazySingleton(() => TopRatedTvSeriesBloc(Get.find()));
  locator.registerLazySingleton(() => PopularTvSeriesBloc(Get.find()));

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
      () => MovieRemoteDataSourceImpl(client: Get.find()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => ioClient);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
