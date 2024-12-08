import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/movie_response.dart';

abstract class TvshowRepository {
  ResultFuture<TVShowResponse> getTvShows(String apiKey);
  ResultFuture<TVShowResponse> getUpcomingTvShows(String apiKey);
  ResultFuture<TVShowResponse> getTrendingTvShows(String apiKey);
}
