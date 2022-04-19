import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final NetworkInfo networkInfo;
  final TVSeriesRemoteDataSource remoteDataSource;
  final TVSeriesLocalDataSource localDataSource;
  // final TVSeriesLocalDataSource localDataSource;

  TVSeriesRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<Failure, List<TVSeries>>> getNowAiringTVSeries() async {
    try {
      final result = await remoteDataSource.getNowAiringTVSeries();
      // localDataSource.cacheNowAiringTVSeries(
      //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      // localDataSource.cacheNowAiringTVSeries(
      //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTVSeries();
      // localDataSource.cacheNowAiringTVSeries(
      //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<List<TVSeries>> readWatchlistTVSeries() async {
    List<TVSeriesModel> tvSeriesModelList =
        await localDataSource.readWatchlistTVSeries();
    var list = <TVSeries>[];
    for (var tvSeriesModel in tvSeriesModelList) {
      list.add(tvSeriesModel.toEntity());
    }
    return list;
  }

  Future<bool> writeWatchlistTVSeries(List<TVSeries> tvSeriesList) {
    var list = <TVSeriesModel>[];
    for (var element in tvSeriesList) {
      list.add(element.toTVSeriesModel());
    }

    return localDataSource.writeWatchlistTVSeries(list);
  }

  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
