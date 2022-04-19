import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final NetworkInfo networkInfo;
  final TVSeriesRemoteDataSource remoteDataSource;
  // final TVSeriesLocalDataSource localDataSource;

  TVSeriesRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  Future<Either<Failure, List<TVSeries>>> getNowAiringTVSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowAiringTVSeries();
        // localDataSource.cacheNowAiringTVSeries(
        //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      return Left(CacheFailure(''));
    }
  }

  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTVSeries();
        // localDataSource.cacheNowAiringTVSeries(
        //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      return Left(CacheFailure(''));
    }
  }

  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTVSeries();
        // localDataSource.cacheNowAiringTVSeries(
        //     result.map((tvSeries) => TVSeriesTable.fromDTO(tvSeries)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      return Left(CacheFailure(''));
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
}
