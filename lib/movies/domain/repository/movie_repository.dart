import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getMovies(String apiKey);
  Future<DataState<List<MovieEntity>>> getTrendingMovies(String apiKey);
  Future<DataState<List<MovieEntity>>> upComingMovies(String apiKey);

  //searching query
  Future<DataState<List<MovieEntity>>> searchMovies(
      String apiKey, String query);
}
