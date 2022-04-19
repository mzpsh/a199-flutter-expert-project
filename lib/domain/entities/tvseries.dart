// ignore_for_file: must_be_immutable

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  TVSeries({
    required this.posterPath,
    required this.id,
    required this.voteAverage,
    required this.overview,
    required this.name,
  });

  TVSeriesModel toTVSeriesModel() => TVSeriesModel(
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
      );

  String? posterPath;
  int id;
  num voteAverage;
  String overview;
  String name;

  @override
  List<Object?> get props => [
        id,
        voteAverage,
        overview,
        name,
      ];
}
