import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/presentation/stores/tvseries_recommendations_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTVSeriesRecommendations extends Mock
    implements GetTVSeriesRecommendations {}

void main() {
  late MockGetTVSeriesRecommendations mockUseCase;
  const errorMessage = 'message';
  const testId = 1;
  setUp(() {
    mockUseCase = MockGetTVSeriesRecommendations();
  });
  test('should return a TVSeriest list as state', () async {
    when((() => mockUseCase.execute(testId)))
        .thenAnswer((invocation) async => Right(<TVSeries>[]));

    final tVSeriesRecommendationsStore =
        TVSeriesRecommendationsStore(getTVSeriesRecommendations: mockUseCase);

    await tVSeriesRecommendationsStore.getRecommendations(testId);

    expect(tVSeriesRecommendationsStore.state, <TVSeries>[]);
  });

  test('should return an error message as error', () async {
    when((() => mockUseCase.execute(testId)))
        .thenAnswer((invocation) async => Left(ServerFailure(errorMessage)));

    final tVSeriesRecommendationsStore =
        TVSeriesRecommendationsStore(getTVSeriesRecommendations: mockUseCase);

    await tVSeriesRecommendationsStore.getRecommendations(testId);

    expect(tVSeriesRecommendationsStore.error, errorMessage);
  });
}
