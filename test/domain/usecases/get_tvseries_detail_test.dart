import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVSeriesRepository extends Mock implements TVSeriesRepository {}

void main() {
  final repository = MockTVSeriesRepository();
  final usecase = GetTVSeriesDetail(repository);
  test('should return a Right with a TVSeriesDetail', () async {
    when(() => repository.getTVSeriesDetail(69))
        .thenAnswer((realInvocation) async => Right(testTVSeriesDetail));

    final resultEither = await usecase.execute(69);

    resultEither.fold(
      (l) => print('test failed'),
      (r) {
        expect(r, testTVSeriesDetail);
      },
    );
  });
}
