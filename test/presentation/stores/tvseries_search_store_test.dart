import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/search_tvseries.dart';
import 'package:ditonton/presentation/stores/tvseries_search_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTVSeries extends Mock implements SearchTVSeries {}

void main() {
  late MockSearchTVSeries mockUseCase;
  const errorMessage = 'message';
  const query = 'test';
  setUp(() {
    mockUseCase = MockSearchTVSeries();
  });
  test('should return a TVSeriest list as state', () async {
    when((() => mockUseCase.execute(query)))
        .thenAnswer((invocation) async => Right(<TVSeries>[testTVSeries]));

    final store = TVSeriesSearchStore(searchTVSeries: mockUseCase);

    await store.findTVSeries(query);

    expect(store.state, <TVSeries>[testTVSeries]);
  });

  test('should return an error message as error', () async {
    when((() => mockUseCase.execute(query)))
        .thenAnswer((invocation) async => Left(ServerFailure(errorMessage)));

    final store = TVSeriesSearchStore(searchTVSeries: mockUseCase);

    await store.findTVSeries(query);

    expect(store.error, errorMessage);
  });
}
