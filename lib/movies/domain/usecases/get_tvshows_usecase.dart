import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';
import 'package:movie_app/movies/domain/repository/tvshow_repository.dart';

class GetTvshowsUsecase {
  final TvshowRepository repository;

  GetTvshowsUsecase(this.repository);

  Future<DataState<List<TVShow>>> getTvshows(String apiKey) {
    return repository.getTvShows(apiKey);
  }

  Future<DataState<List<TVShow>>> getTrendingTvShows(String apiKey) {
    return repository.getTrendingTvShows(apiKey);
  }
}
