// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  TVSeries({
    required this.posterPath,
    required this.id,
    required this.voteAverage,
    required this.overview,
    required this.name,
  });

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
