import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/movies/domain/entity/movie_response.dart';

abstract class MovieRepository {
  ResultFuture<MovieResponse> getMovies(String apiKey);
  ResultFuture<MovieResponse> getTrendingMovies(String apiKey);
  ResultFuture<MovieResponse> upComingMovies(String apiKey);

  //searching query
  ResultFuture<MovieResponse> searchMovies(String apiKey, String query);

  //handle favourite movies
  // ResultFuture<List<MovieEntity>> getFavoriteMovies();
  // ResultFuture<void> removeMovieFromFavorites(MovieEntity movie);
}
