import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/domain/repository/movie_repository.dart';

class GetMoviesUsecase {
  final MovieRepository repository;

  GetMoviesUsecase(this.repository);

  // Fetch regular movies
  Future<DataState<List<MovieEntity>>> getMovies(String apiKey) {
    return repository.getMovies(apiKey);
  }

  // Fetch trending movies
  Future<DataState<List<MovieEntity>>> getTrendingMovies(String apiKey) {
    return repository.getTrendingMovies(apiKey);
  }

//Fetch Upcoming Movies
  Future<DataState<List<MovieEntity>>> upComingMovies(String apiKey) {
    return repository.upComingMovies(apiKey);
  }
}
