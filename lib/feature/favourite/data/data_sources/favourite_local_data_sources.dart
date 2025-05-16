import 'package:movie_app/feature/movies/domain/entity/movie.dart';

abstract class FavouriteLocalDataSources {
  Future<void> addMovieToFavorites(Movie movie);
  Future<List<Movie>> getFavouriteMovies();

}
