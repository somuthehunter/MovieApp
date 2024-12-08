import 'package:movie_app/core/typedef/typedef.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/movie_response.dart';
import 'package:movie_app/feature/tv_shows/domain/repositories/tvshow_repository.dart';

class GetTvshowsUsecase {
  final TvshowRepository repository;

  GetTvshowsUsecase(this.repository);

  ResultFuture<TVShowResponse> getTvshows(String apiKey) {
    return repository.getTvShows(apiKey);
  }
}
