import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_airing_airing_tvseries.dart';
import 'package:ditonton/presentation/controller/tvseries_list_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNowAiringTVSeries extends Mock implements GetNowAiringTVSeries {}

void main() {
  late MockGetNowAiringTVSeries mockGetNowAiringTVSeries;
  late TVSeriesListController controller;

  setUp(() {
    mockGetNowAiringTVSeries = MockGetNowAiringTVSeries();
    when(() => mockGetNowAiringTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('fafa')));
    controller = Get.put(
        TVSeriesListController(getNowAiringTVSeries: mockGetNowAiringTVSeries));
  });

  test('should call the function', () {
    verify(() => mockGetNowAiringTVSeries.execute());
  });
}
