import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTVSeriesRepository extends Mock implements TVSeriesRepository {}

void main() {
  final repository = MockTVSeriesRepository();
  final usecase = GetTopRatedTVSeries(repository);
  test('should return a Right with a List of TVSeries', () async {
    when(repository.getTopRatedTVSeries)
        .thenAnswer((realInvocation) async => Right(<TVSeries>[]));

    final resultEither = await usecase.execute();

    resultEither.fold(
      (l) => print('test failed'),
      (r) {
        expect(r, <TVSeries>[]);
      },
    );
  });
}
