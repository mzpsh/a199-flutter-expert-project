import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/stores/popular_tvseries_list_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularTVSeries extends Mock implements GetPopularTVSeries {}

void main() {
  late MockGetPopularTVSeries mockUseCase;
  setUp(() {
    mockUseCase = MockGetPopularTVSeries();
  });
  test('should return a TVSeriest list as state', () {
    when(mockUseCase.execute).thenAnswer((_) async => Right(<TVSeries>[]));

    final nowAiringTVSeriesListStore =
        PopularTVSeriesListStores(getPopularTVSeries: mockUseCase);

    expect(nowAiringTVSeriesListStore.state, <TVSeries>[]);
  });

  test('should return an error message as error', () async {
    const errorMessage = 'message';
    when(mockUseCase.execute)
        .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

    final nowAiringTVSeriesListStore =
        PopularTVSeriesListStores(getPopularTVSeries: mockUseCase);

    await nowAiringTVSeriesListStore.fetchPopularTVSeries();

    expect(nowAiringTVSeriesListStore.error, errorMessage);
  });
}
