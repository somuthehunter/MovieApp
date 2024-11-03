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
    try {
      final httpResponse = await _moviesApiService.getMovies(apiKey);

      if (httpResponse.statusCode == HttpStatus.ok) {
        final results = httpResponse.data['results'] as List<dynamic>;

        // Map the JSON response to MovieModel instances
        List<MovieEntity> movies = results.map((json) {
          // print('JSON item before mapping: $json'); // Debugging print
          return MovieModel.fromJson(json as Map<String, dynamic>);
        }).toList();

        return DataSuccess(movies);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.requestOptions,
            response: httpResponse,
            error: "Failed to load movies: ${httpResponse.statusMessage}",
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

  @override
  Future<DataState<List<MovieEntity>>> getTrendingMovies(String apiKey) async {
    try {
      // Make the API call and print the request details
      print("getTrendingMovies called");
      final response = await _moviesApiService.getTrendingMovies(apiKey);
      print(
          "API call made to get trending movies. URL: ${response.requestOptions.uri}");

      // Check the response status code
      if (response.statusCode == HttpStatus.ok) {
        // If successful, process the results
        final results_trends = response.data['results'] as List<dynamic>;
        print("Response received successfully: ${response.data}");

        List<MovieEntity> trendingMovies = results_trends.map((json) {
          return MovieModel.fromJson(json as Map<String, dynamic>);
        }).toList();
        print("Response : ${trendingMovies}");
        // Log the trending movies
        for (var movie in trendingMovies) {
          print('Trending MovieEntity: ${movie.toString()}');
        }

        return DataSuccess(trendingMovies);
      } else {
        // Handle the case where the response status is not OK
        print("Failed to load trending movies: ${response.statusMessage}");
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: "Failed to load trending movies: ${response.statusMessage}",
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      // Handle Dio specific exceptions
      print("DioException occurred: ${e.message}");
      return DataFailed(e);
    } catch (e) {
      // Handle any other exceptions
      print("An error occurred: ${e.toString()}");
      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<List<MovieEntity>>> upComingMovies(String apiKey) async {
    try {
      // Make the API call and print the request details
      // print("getTrendingMovies called");
      final response = await _moviesApiService.upComingMovies(apiKey);
      // print(
      //     "API call made to get trending movies. URL: ${response.requestOptions.uri}");

      // Check the response status code
      if (response.statusCode == HttpStatus.ok) {
        // If successful, process the results
        final results_upcoming = response.data['results'] as List<dynamic>;
        print("Response received successfully: ${response.data}");

        List<MovieEntity> upcomingMovies = results_upcoming.map((json) {
          return MovieModel.fromJson(json as Map<String, dynamic>);
        }).toList();
        // print("Response : ${trendingMovies}");
        // // Log the trending movies
        // for (var movie in trendingMovies) {
        //   print('Trending MovieEntity: ${movie.toString()}');
        // }

        return DataSuccess(upcomingMovies);
      } else {
        // Handle the case where the response status is not OK
        print("Failed to load trending movies: ${response.statusMessage}");
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: "Failed to load trending movies: ${response.statusMessage}",
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      // Handle Dio specific exceptions
      print("DioException occurred: ${e.message}");
      return DataFailed(e);
    } catch (e) {
      // Handle any other exceptions
      print("An error occurred: ${e.toString()}");
      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }
}
