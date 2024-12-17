import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_bloc.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_event.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_state.dart';

class TrendingTvShows extends StatelessWidget {
  const TrendingTvShows({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TvShowBloc>()..add(GetTrendingTvShows()),
      child: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoading) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Utilities.showLoadingBanner(context: context, height: 180),
            );
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
                              AppRoutes.allTrendingSeries,
                              arguments: trendingTvShows,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppColors.primary,
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
                        return Utilities.buildThumbnail(
                            context: context, tvShow: tvShow);
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
}