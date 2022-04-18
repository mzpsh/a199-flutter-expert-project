import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetNowAiringTVSeries {
  final TVSeriesRepository repository;

  GetNowAiringTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    print('domain/usecases: GetNowAiringTVSeries called');
    return repository.getNowAiringTVSeries();
  }
}
