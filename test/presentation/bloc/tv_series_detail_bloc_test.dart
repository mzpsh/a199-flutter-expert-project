import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTVSeriesDetail extends Mock implements GetTVSeriesDetail {}

void main() {
  late GetTVSeriesDetail usecase;
  late TVSeriesDetailBloc bloc;
  const testId = 69;

  setUp(() {
    usecase = MockGetTVSeriesDetail();
    bloc = TVSeriesDetailBloc(usecase);
  });
  group('TVSeriesDetailBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, TVSeriesDetailLoading());
    });

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'emits [Loading, HasData] when OnFetchTVSeriesDetail is added.',
      build: () {
        when(() => usecase.execute(testId))
            .thenAnswer((_) async => Right(testTVSeriesDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesDetail(testId)),
      expect: () =>
          [TVSeriesDetailLoading(), TVSeriesDetailHasData(testTVSeriesDetail)],
      verify: (bloc) => verify(() => usecase.execute(testId)),
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'emits [Loading, Error] when OnFetchTVSeriesDetail is added and rrror.',
      build: () {
        when(() => usecase.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('message')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesDetail(testId)),
      expect: () => [TVSeriesDetailLoading(), TVSeriesDetailError('message')],
      verify: (bloc) => verify(() => usecase.execute(testId)),
    );
  });
}
