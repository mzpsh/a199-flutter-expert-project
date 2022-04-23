import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/presentation/stores/tvseries_detail_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTVSeriesDetail extends Mock implements GetTVSeriesDetail {}

void main() {
  late MockGetTVSeriesDetail mockUseCase;
  const id = 1;
  const errorMessage = 'erorrMessage';
  setUp(() {
    mockUseCase = MockGetTVSeriesDetail();
  });
  test('should return a TVSeries detail as state', () async {
    when(() => mockUseCase.execute(id))
        .thenAnswer((_) async => Right(testTVSeriesDetail));

    final store = TVSeriesDetailStore(getTVSeriesDetail: mockUseCase);

    await store.fetchTVSeriesDetail(id);

    expect(store.state, testTVSeriesDetail);
  });

  test('should return an error message as error', () async {
    when(() => mockUseCase.execute(id))
        .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

    final store = TVSeriesDetailStore(getTVSeriesDetail: mockUseCase);

    await store.fetchTVSeriesDetail(id);

    expect(store.error, errorMessage);
  });
}
