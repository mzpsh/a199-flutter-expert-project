import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final num voteAverage;
  final String overview;
  final String firstAirDate;
  final List<int> genreIds;
  final num voteCount;
  final String name;
  final String originalName;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"],
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"],
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": backdropPath,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  TVSeries toEntity() {
    return TVSeries(
      posterPath: this.posterPath,
      id: this.id,
      voteAverage: this.voteAverage,
      overview: this.overview,
      name: this.name,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        genreIds,
        voteCount,
        name,
        originalName,
      ];
}
