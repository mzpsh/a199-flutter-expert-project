import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTopRatedTVSeries extends Mock implements GetTopRatedTVSeries {}

void main() {
  late GetTopRatedTVSeries usecase;
  late TopRatedTvSeriesBloc bloc;

  setUp(() {
    usecase = MockGetTopRatedTVSeries();
    bloc = TopRatedTvSeriesBloc(usecase);
  });
  group('TopRatedTvSeriesBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, TopRatedTvSeriesLoading());
    });

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'emits [Loading, HasData] when OnFetchNowAiringTvSeries is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'emits [Loading, Error] when OnFetchNowAiringTvSeries is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
