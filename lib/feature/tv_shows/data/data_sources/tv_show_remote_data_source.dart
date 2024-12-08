import 'package:movie_app/feature/tv_shows/data/models/tv_show_response_model.dart';

abstract class TvShowRemoteDataSource {
  Future<TVShowResponseModel> getTvShows(String apiKey);
}
