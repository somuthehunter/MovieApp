import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart'; // Assuming this exists
import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_event.dart';
import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_state.dart';

class TrendingTvShows extends StatelessWidget {
  const TrendingTvShows({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TvShowBloc>()..add(GetTrendingTvShows()),
      child: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvShowDone) {
            final trendingTvShows = state.tvShows; // Correct field name

            if (trendingTvShows.isEmpty) {
              return const Center(
                  child: Text('No trending TV shows available'));
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending Series',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.allWebSeries,
                              arguments: trendingTvShows,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.blue[600],
                          ),
                          child: const Text('See Details'),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: trendingTvShows.map((tvShow) {
                        return buildTvShowThumbnail(context, tvShow);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TvShowError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildTvShowThumbnail(BuildContext context, TVShow tvShow) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.webSeriesDetails,
            arguments: tvShow, // Pass the single TV show entity
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '$basePosterUrl${tvShow.posterPath}',
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
            // Heart icon on the top-right corner
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite_border,
                color: Colors.blue,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
