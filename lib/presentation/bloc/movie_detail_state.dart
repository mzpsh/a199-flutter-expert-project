part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;
  MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
