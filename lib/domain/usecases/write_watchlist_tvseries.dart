import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class WriteWatchlistTVSeries {
  final TVSeriesRepository repository;
  WriteWatchlistTVSeries(this.repository);

  Future<bool> execute(List<TVSeries> list) {
    return repository.writeWatchlistTVSeries(list);
  }
}
