import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/tv_show_entity.dart';

import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_event.dart';
import 'package:movie_app/movies/presentation/bloc/tv_show/tvshow_state.dart';

class TvshowsWidget extends StatelessWidget {
  const TvshowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TvShowBloc>()..add(GetTvShows()),
      child: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvShowDone) {
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
                            Navigator.pushNamed(context, AppRoutes.allWebSeries,
                                arguments: state.tvShows);
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
                      children: state.tvShows.map((movie) {
                        return buildMovieThumbnail(context, movie);
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

  Widget buildMovieThumbnail(BuildContext context, TVShow movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.webSeriesDetails,
            arguments: movie, // Pass a single movie entity
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '$basePosterUrl${movie.posterPath}',
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
      ),
    );
  }
}
