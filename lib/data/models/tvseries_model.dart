import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.posterPath,
    required this.id,
    required this.voteAverage,
    required this.overview,
    required this.name,
  });

  final String? posterPath;
  final int id;
  final num voteAverage;
  final String overview;
  final String name;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        posterPath: json["poster_path"],
        id: json["id"],
        voteAverage: json["vote_average"],
        overview: json["overview"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "overview": overview,
        "name": name,
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

  factory TVSeriesModel.fromEntity(TVSeries entity) => TVSeriesModel(
      posterPath: entity.posterPath,
      id: entity.id,
      voteAverage: entity.voteAverage,
      overview: entity.overview,
      name: entity.name);

  @override
  List<Object?> get props => [
        posterPath,
        id,
        voteAverage,
        overview,
        name,
      ];
}
