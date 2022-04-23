import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
import 'package:ditonton/presentation/stores/now_airing_tvseries_list_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNowAiringTVSeries extends Mock implements GetNowAiringTVSeries {}

void main() {
  test('should return a TVSeriest list as state', () {
    final MockGetNowAiringTVSeries mockGetNowAiringTVSeries =
        MockGetNowAiringTVSeries();
    when(mockGetNowAiringTVSeries.execute)
        .thenAnswer((_) async => Right(<TVSeries>[]));
    final nowAiringTVSeriesListStore = NowAiringTVSeriesListStores(
        getNowAiringTVSeries: mockGetNowAiringTVSeries);

    expect(nowAiringTVSeriesListStore.state, <TVSeries>[]);
  });

  test('should return an error message as error', () async {
    final MockGetNowAiringTVSeries mockGetNowAiringTVSeries =
        MockGetNowAiringTVSeries();
    const errorMessage = 'message';
    when(mockGetNowAiringTVSeries.execute)
        .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

    final nowAiringTVSeriesListStore = NowAiringTVSeriesListStores(
        getNowAiringTVSeries: mockGetNowAiringTVSeries);

    await nowAiringTVSeriesListStore.fetchNowAiringTVSeries();

    expect(nowAiringTVSeriesListStore.error, errorMessage);
  });
}
