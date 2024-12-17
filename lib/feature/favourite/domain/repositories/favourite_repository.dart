import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class FavouriteRepository {
  ResultFuture<void> addMovieToFavorites(Movie movie);
  ResultFuture<List<Movie>> getFavouriteMovies();
}