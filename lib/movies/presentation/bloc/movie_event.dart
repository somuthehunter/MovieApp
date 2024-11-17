import 'package:equatable/equatable.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMovies extends MovieEvent {}

class GetTrendingMovies extends MovieEvent {}

class UpComingMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies({required this.query});

  @override
  List<Object?> get props => [query];
}

class AddToFavourites extends MovieEvent {
  final MovieEntity movie;

  AddToFavourites({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class RemoveFromFavourites extends MovieEvent {
  final MovieEntity movie;

  RemoveFromFavourites({required this.movie});

  @override
  List<Object?> get props => [movie];
}
