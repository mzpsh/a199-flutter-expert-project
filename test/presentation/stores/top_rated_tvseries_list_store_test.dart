import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/stores/top_rated_tvseries_list_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTopRatedTVSeries extends Mock implements GetTopRatedTVSeries {}

void main() {
  late MockGetTopRatedTVSeries mockUseCase;
  setUp(() {
    mockUseCase = MockGetTopRatedTVSeries();
  });
  test('should return a TVSeriest list as state', () {
    when(mockUseCase.execute).thenAnswer((_) async => Right(<TVSeries>[]));

    final nowAiringTVSeriesListStore =
        TopRatedTVSeriesListStores(getTopRatedTVSeries: mockUseCase);

    expect(nowAiringTVSeriesListStore.state, <TVSeries>[]);
  });

  test('should return an error message as error', () async {
    const errorMessage = 'message';
    when(mockUseCase.execute)
        .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

    final nowAiringTVSeriesListStore =
        TopRatedTVSeriesListStores(getTopRatedTVSeries: mockUseCase);

    await nowAiringTVSeriesListStore.fetchPopularTVSeries();

    expect(nowAiringTVSeriesListStore.error, errorMessage);
  });
}
