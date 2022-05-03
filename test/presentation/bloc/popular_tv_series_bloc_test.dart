import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetPopularTVSeries extends Mock implements GetPopularTVSeries {}

void main() {
  late GetPopularTVSeries usecase;
  late PopularTvSeriesBloc bloc;

  setUp(() {
    usecase = MockGetPopularTVSeries();
    bloc = PopularTvSeriesBloc(usecase);
  });
  group('TopRatedTvSeriesBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, PopularTvSeriesLoading());
    });

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'emits [Loading, HasData] when OnFetchNowAiringTvSeries is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'emits [Loading, Error] when OnFetchNowAiringTvSeries is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
