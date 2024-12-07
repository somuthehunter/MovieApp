import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_bloc.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_event.dart';
import 'package:movie_app/feature/tv_shows/presentation/bloc/tvshow_state.dart';

class TvshowsWidget extends StatelessWidget {
  const TvshowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TvShowBloc>()..add(GetTvShows()),
      child: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          switch (state) {
            case TvShowLoading _:
              return const Center(child: CircularProgressIndicator());
            case TvShowDone _:
              if (state.tvShows.isEmpty) {
                return const Center(
                    child: Text('Web Series are on the way. Please Wait'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Web Series',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.allWebSeries,
                                  arguments: state.tvShows);
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
                        children: state.tvShows.map((tvShow) {
                          return Utilities.buildThumbnail(
                              context: context, tvShow: tvShow);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            case TvShowError _:
              return Center(child: Text('Error: ${state.error}'));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
