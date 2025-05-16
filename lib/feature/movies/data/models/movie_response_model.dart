import 'package:movie_app/feature/movies/data/models/movie_models.dart';
import 'package:movie_app/feature/movies/domain/entity/movie_response.dart';

class MovieResponseModel extends MovieResponse {
  const MovieResponseModel(
      {required super.page,
      required super.movies,
      required super.totalPages,
      required super.totalResults});

  factory MovieResponseModel.fromMap(Map<String, dynamic> map) {
    return MovieResponseModel(
        page: map['page'],
        movies: MovieModel.toEntityList(MovieModel.fromList(
            List<Map<String, dynamic>>.from(map['results']))),
        totalPages: map['total_pages'],
        totalResults: map['total_results']);
  }

  MovieResponse toEntity() => MovieResponse(
      page: page,
      movies: movies,
      totalPages: totalPages,
      totalResults: totalResults);
}
