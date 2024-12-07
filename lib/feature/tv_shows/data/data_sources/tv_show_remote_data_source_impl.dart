import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/feature/tv_shows/data/data_sources/tv_show_remote_data_source.dart';
import 'package:movie_app/feature/tv_shows/data/models/tv_show_model.dart';

class TvShowRemoteDataSourceImpl extends TvShowRemoteDataSource {
  final ApiClient client;

  TvShowRemoteDataSourceImpl(this.client);

  @override
  Future<List<TVShowModel>> getTvShows(String apiKey) async {
    final response = await client.get(
      'tv/popular',
      queryParameters: {
        'api_key': apiKey,
      },
    );
    return TVShowModel.fromList(response);
  }
}
