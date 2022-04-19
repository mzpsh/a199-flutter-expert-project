import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.voteAverage,
    required this.overview,
  });

  final int id;
  final String? posterPath;
  final String name;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final num voteAverage;
  final String overview;

  TVSeries toTVSeries() => TVSeries(
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage);

  @override
  List<Object?> get props => [
        id,
        posterPath,
        name,
        numberOfSeasons,
        numberOfEpisodes,
        voteAverage,
        overview
      ];
}
