import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tvseries.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetNowAiringTVSeries extends Mock implements GetNowAiringTVSeries {}

void main() {
  late GetNowAiringTVSeries usecase;
  late NowAiringTvSeriesBloc bloc;

  setUp(() {
    usecase = MockGetNowAiringTVSeries();
    bloc = NowAiringTvSeriesBloc(usecase);
  });

  group('NowAiringTvSeriesBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, NowAiringTvSeriesLoading());
    });

    blocTest<NowAiringTvSeriesBloc, NowAiringTvSeriesState>(
      'emits [Loading, HasData] when OnFetchNowAiringTvSeries is added.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowAiringTvSeries()),
      expect: () => <NowAiringTvSeriesState>[
        NowAiringTvSeriesLoading(),
        NowAiringTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );

    blocTest<NowAiringTvSeriesBloc, NowAiringTvSeriesState>(
      'emits [Loading, Error] when OnFetchNowAiringTvSeries is added and error.',
      build: () {
        when(() => usecase.execute())
            .thenAnswer((invocation) async => Right([testTVSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(OnFetchNowAiringTvSeries()),
      expect: () => <NowAiringTvSeriesState>[
        NowAiringTvSeriesLoading(),
        NowAiringTvSeriesHasData([testTVSeries])
      ],
      verify: (bloc) => verify(() => usecase.execute()),
    );
  });
}
