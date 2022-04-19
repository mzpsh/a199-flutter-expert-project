import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailResponse extends Equatable {
  TVSeriesDetailResponse({
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

  factory TVSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailResponse(
        id: json['id'],
        posterPath: json['poster_path'],
        name: json['name'],
        numberOfSeasons: json['number_of_seasons'],
        numberOfEpisodes: json['number_of_episodes'],
        voteAverage: json['vote_average'],
        overview: json['overview'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "name": name,
        "number_of_seasons": numberOfSeasons,
        "number_of_episodes": numberOfEpisodes,
        "vote_average": voteAverage,
        "overview": overview,
      };

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      id: this.id,
      posterPath: this.posterPath,
      name: this.name,
      numberOfSeasons: this.numberOfSeasons,
      numberOfEpisodes: this.numberOfEpisodes,
      voteAverage: this.voteAverage,
      overview: this.overview,
    );
  }

  @override
  List<Object?> get props => [
        id,
        posterPath,
        name,
        numberOfSeasons,
        numberOfEpisodes,
        voteAverage,
        overview,
      ];
}
