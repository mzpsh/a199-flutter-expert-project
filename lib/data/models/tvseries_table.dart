import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TVSeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TVSeriesTable.fromEntity(TVSeriesModel movie) => TVSeriesTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
        id: map['id'],
        title: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory TVSeriesTable.fromDTO(TVSeriesModel movie) => TVSeriesTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
