import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/data/data_models/movie_models.dart';
import 'package:movie_app/movies/data/resources/movies_api_service.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MoviesApiService _moviesApiService;

  MovieRepositoryImpl(this._moviesApiService);

  @override
  Future<DataState<List<MovieEntity>>> getMovies(String apiKey) async {
    return await _fetchMovies(
      fetchAction: () => _moviesApiService.getMovies(apiKey),
      errorMessage: "Failed to load movies",
    );
  }

  @override
  Future<DataState<List<MovieEntity>>> getTrendingMovies(String apiKey) async {
    return await _fetchMovies(
      fetchAction: () => _moviesApiService.getTrendingMovies(apiKey),
      errorMessage: "Failed to load trending movies",
    );
  }

  @override
  Future<DataState<List<MovieEntity>>> upComingMovies(String apiKey) async {
    return await _fetchMovies(
      fetchAction: () => _moviesApiService.upComingMovies(apiKey),
      errorMessage: "Failed to load upcoming movies",
    );
  }

  @override
  Future<DataState<List<MovieEntity>>> searchMovies(
      String apiKey, String query) async {
    return await _fetchMovies(
      fetchAction: () => _moviesApiService.searchMovies(apiKey, query),
      errorMessage: "Failed to load search results",
    );
  }

  /// Centralized method for handling API calls, responses, and error handling.
  Future<DataState<List<MovieEntity>>> _fetchMovies({
    required Future<Response> Function() fetchAction,
    required String errorMessage,
  }) async {
    try {
      final response = await fetchAction();

      if (response.statusCode == HttpStatus.ok) {
        final results = response.data['results'] as List<dynamic>;

        List<MovieEntity> movies = results
            .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return DataSuccess(movies);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: "$errorMessage: ${response.statusMessage}",
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }
}
