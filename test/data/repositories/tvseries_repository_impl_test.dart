import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVSeriesRemoteDataSource extends Mock
    implements TVSeriesRemoteDataSource {}

class MockTVSeriesLocalDataSource extends Mock
    implements TVSeriesLocalDataSource {}

void main() {
  final mockRemoteDataSource = MockTVSeriesRemoteDataSource();
  final mockLocalDataSource = MockTVSeriesLocalDataSource();
  final repository = TVSeriesRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource);
  group('getNowAiringTVSeries', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.getNowAiringTVSeries())
          .thenAnswer((invocation) async => [testTVSeriesModel]);

      final result = await repository.getNowAiringTVSeries();
      final resultValue = result.getOrElse(() => []);
      expect(resultValue, [testTVSeries]);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.getNowAiringTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getNowAiringTVSeries();
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('getPopularTVSeries', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((invocation) async => [testTVSeriesModel]);

      final result = await repository.getPopularTVSeries();
      final resultValue = result.getOrElse(() => []);
      expect(resultValue, [testTVSeries]);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getPopularTVSeries();
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('getTopRatedTVSeries', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((invocation) async => [testTVSeriesModel]);

      final result = await repository.getTopRatedTVSeries();
      final resultValue = result.getOrElse(() => []);
      expect(resultValue, [testTVSeries]);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());

      final result = await repository.getTopRatedTVSeries();
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('getTVSeriesDetail', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.getTVSeriesDetail(69))
          .thenAnswer((invocation) async => testTVSeriesDetailResponse);

      final result = await repository.getTVSeriesDetail(69);
      final resultValue = result.getOrElse(() => testTVSeriesDetail);
      expect(resultValue.id, testTVSeriesDetail.id);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.getTVSeriesDetail(69))
          .thenThrow(ServerException());

      final result = await repository.getTVSeriesDetail(69);
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('readWatchlistTVSeries', () {
    test('should be able to return a List of TVSeries', () async {
      when(() => mockLocalDataSource.readWatchlistTVSeries())
          .thenAnswer((invocation) async => <TVSeriesModel>[]);
      final result = await repository.readWatchlistTVSeries();
      expect(result, <TVSeriesModel>[]);
    });
  });

  group('readWatchlistTVSeries', () {
    test('should be able to return a List of TVSeries', () async {
      when(() =>
              mockLocalDataSource.writeWatchlistTVSeries([testTVSeriesModel]))
          .thenAnswer((invocation) async => true);
      final result = await repository.writeWatchlistTVSeries([testTVSeries]);

      expect(result, true);
    });
  });
  group('searchTVSeries', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.searchTVSeries('69'))
          .thenAnswer((invocation) async => [testTVSeriesModel]);

      final result = await repository.searchTVSeries('69');
      final resultValue = result.getOrElse(() => []);
      expect(resultValue[0].id, testTVSeriesDetail.id);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.searchTVSeries('69'))
          .thenThrow(ServerException());

      final result = await repository.searchTVSeries('69');
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('getTVSeriesRecommendations', () {
    test('should be able to return Right with List of TVSeries', () async {
      when(() => mockRemoteDataSource.getTVSeriesRecommendations(69))
          .thenAnswer((invocation) async => [testTVSeriesModel]);

      final result = await repository.getTVSeriesRecommendations(69);
      final resultValue = result.getOrElse(() => []);
      expect(resultValue[0].id, testTVSeriesDetail.id);
    });
    test('should be able to return Left with ServerFailure', () async {
      when(() => mockRemoteDataSource.getTVSeriesRecommendations(69))
          .thenThrow(ServerException());

      final result = await repository.getTVSeriesRecommendations(69);
      expect(result, equals(Left(ServerFailure(''))));
    });
  });
}
