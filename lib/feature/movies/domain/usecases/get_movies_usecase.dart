import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/movies/domain/entity/movie_response.dart';
import 'package:movie_app/feature/movies/domain/repository/movie_repository.dart';

class GetMoviesUsecase {
  final MovieRepository repository;

  GetMoviesUsecase(this.repository);

  // Fetch regular movies
  ResultFuture<MovieResponse> getMovies(String apiKey) {
    return repository.getMovies(apiKey);
  }

  // Fetch trending movies
  ResultFuture<MovieResponse> getTrendingMovies(String apiKey) {
    return repository.getTrendingMovies(apiKey);
  }

//Fetch Upcoming Movies
  ResultFuture<MovieResponse> upComingMovies(String apiKey) {
    return repository.upComingMovies(apiKey);
  }

  //searching movies
  ResultFuture<MovieResponse> searchMovies(String apiKey, String query) {
    return repository.searchMovies(apiKey, query);
  }

  //favourite movies handler
  // ResultFuture<List<MovieEntity>> getFavoriteMovies() =>
  //     repository.getFavoriteMovies();

  // // Remove from Favorites
  // ResultFuture<void> removeMovieFromFavorites(MovieEntity movie) =>
  //     repository.removeMovieFromFavorites(movie);
}
