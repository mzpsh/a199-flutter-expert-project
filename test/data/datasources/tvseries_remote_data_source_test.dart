import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../dummy_data/tvseries_detail.dart';
import '../../dummy_data/tvseries_list.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  final Client client = MockHttpClient();
  final dataSource = TVSeriesRemoteDataSourceImpl(client: client);
  group('getNowAiringTVSeries', () {
    test('should be able to return List of TVSeries ', () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 200));

      final result = await dataSource.getNowAiringTVSeries();

      expect(result, [testTVSeriesModel]);
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.getNowAiringTVSeries();

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('getPopularTVSeries', () {
    test('should be able to return List of TVSeries ', () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 200));

      final result = await dataSource.getPopularTVSeries();

      expect(result, [testTVSeriesModel]);
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.getPopularTVSeries();

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('getTopRatedTVSeries', () {
    test('should be able to return List of TVSeries ', () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 200));

      final result = await dataSource.getTopRatedTVSeries();

      expect(result, [testTVSeriesModel]);
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.getTopRatedTVSeries();

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('getTVSeriesDetail', () {
    test('should be able to return TVSeriesDetailResponse ', () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/69?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_detail_json, 200));

      final result = await dataSource.getTVSeriesDetail(69);

      expect(
        result,
        TVSeriesDetailResponse.fromJson(
          jsonDecode(tvseries_detail_json),
        ),
      );
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() => client.get(Uri.parse('$BASE_URL/tv/69?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.getTVSeriesDetail(69);

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('searchTVSeries', () {
    test('should be able to return a List of TVSeries ', () async {
      when(() =>
              client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=420')))
          .thenAnswer((_) async => Response(tvseries_list_json, 200));

      final result = await dataSource.searchTVSeries('420');

      expect(result, [testTVSeriesModel]);
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() =>
              client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=420')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.searchTVSeries('420');

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('getTVSeriesRecommendations', () {
    test('should be able to return a List of TVSeries ', () async {
      when(() =>
              client.get(Uri.parse('$BASE_URL/tv/69/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 200));

      final result = await dataSource.getTVSeriesRecommendations(69);

      expect(result, [testTVSeriesModel]);
    });
    test(
        'should be able to return ServerException if http response status code other than 200',
        () async {
      when(() =>
              client.get(Uri.parse('$BASE_URL/tv/69/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response(tvseries_list_json, 42069));

      final result = dataSource.getTVSeriesRecommendations(69);

      // print(result);
      // print(result is ServerException);
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
