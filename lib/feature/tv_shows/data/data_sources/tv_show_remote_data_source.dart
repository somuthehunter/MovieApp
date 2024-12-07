import 'package:movie_app/feature/tv_shows/data/models/tv_show_model.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TVShowModel>> getTvShows(String apiKey);
}
