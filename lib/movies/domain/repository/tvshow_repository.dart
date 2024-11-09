
import 'package:movie_app/config/data_state.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';

abstract class TvshowRepository {
Future<DataState<List<TVShow>>> getTvShows(String apiKey);
}