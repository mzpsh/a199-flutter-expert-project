import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getNowAiringTVSeries() {
    print('data/repositories called');
    return Future.value(Left(ServerFailure('f')));
  }
}
