import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/data/data_models/tv_show_model.dart';
import 'package:movie_app/movies/data/resources/movies_api_service.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';
import 'package:movie_app/movies/domain/repository/tvshow_repository.dart';

class TvshowsRepositoryImpls extends TvshowRepository {
  final MoviesApiService _apiService;

  TvshowsRepositoryImpls(this._apiService);

  @override
  Future<DataState<List<TVShow>>> getTvShows(String apiKey) async {
    try {
      // Make the API call and print the request details
      // print("getTrendingMovies called");
      final response = await _apiService.getTvShows(apiKey);

      // Check the response status code
      if (response.statusCode == HttpStatus.ok) {
        // If successful, process the results
        final tvShow = response.data['results'] as List<dynamic>;
        print("Response received successfully: ${response.data}");

        List<TVShow> tvShows = tvShow.map((json) {
          return TVShowModel.fromJson(json as Map<String, dynamic>);
        }).toList();

        return DataSuccess(tvShows);
      } else {
        // Handle the case where the response status is not OK

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

      return DataFailed(e);
    } catch (e) {
      // Handle any other exceptions

      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<List<TVShow>>> getTrendingTvShows(String apiKey) async {
    try {
      // Make the API call and print the request details
      // print("getTrendingMovies called");
      final response = await _apiService.getTrendingTvShows(apiKey);

      // Check the response status code
      if (response.statusCode == HttpStatus.ok) {
        // If successful, process the results
        final tvShow = response.data['results'] as List<dynamic>;
        print("Response received successfully: ${response.data}");

        List<TVShow> tvShows = tvShow.map((json) {
          return TVShowModel.fromJson(json as Map<String, dynamic>);
        }).toList();

        return DataSuccess(tvShows);
      } else {
        // Handle the case where the response status is not OK

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

      return DataFailed(e);
    } catch (e) {
      // Handle any other exceptions

      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  
  @override
  Future<DataState<List<TVShow>>> getUpcomingTvShows(String apiKey) async {
    try {
      // Make the API call and print the request details
      // print("getTrendingMovies called");
      final response = await _apiService.getUpcomingTvShows(apiKey);

      // Check the response status code
      if (response.statusCode == HttpStatus.ok) {
        // If successful, process the results
        final tvShow = response.data['results'] as List<dynamic>;
        print("Response received successfully: ${response.data}");

        List<TVShow> tvShows = tvShow.map((json) {
          return TVShowModel.fromJson(json as Map<String, dynamic>);
        }).toList();

        return DataSuccess(tvShows);
      } else {
        // Handle the case where the response status is not OK

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

      return DataFailed(e);
    } catch (e) {
      // Handle any other exceptions

      return DataFailed(
        DioException(
          error: e.toString(),
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }
}
