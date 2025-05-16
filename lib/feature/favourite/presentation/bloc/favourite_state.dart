import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteMovieAdded extends FavouriteState {
  final Movie movie;

  FavouriteMovieAdded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class FavouriteMovieLoaded extends FavouriteState {
  final List<Movie> favoriteMovies;

  FavouriteMovieLoaded(this.favoriteMovies);

  @override
  List<Object?> get props => [favoriteMovies];
}

class FavoriteMoviesError extends FavouriteState {
  final String error;

  FavoriteMoviesError(this.error);

  @override
  List<Object?> get props => [error];
}
