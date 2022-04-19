import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class ReadWatchlistTVSeries {
  final TVSeriesRepository repository;
  ReadWatchlistTVSeries(this.repository);

  Future<List<TVSeries>> execute() {
    return repository.readWatchlistTVSeries();
  }
}
