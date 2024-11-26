import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';

class UpComingMoviesWidget extends StatelessWidget {
  const UpComingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()
        ..add(UpComingMovies()), // Event for fetching upcoming movies
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state) {
            case MovieLoading _:
              return const Center(child: CircularProgressIndicator());
            case MovieDone _:
              if (state.upComingMovies.isEmpty) {
                return const Center(
                    child: Text('No upcoming movies available'));
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
                            'Upcoming Movies',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.upcomingMovies,
                                  arguments: state
                                      .upComingMovies); // Navigates to the details screen
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
                        children: state.upComingMovies.map((movie) {
                          return Utilities.buildThumbnail(
                              context: context,
                              movie: movie); // Builds movie thumbnails
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            case MovieError _:
              return Center(child: Text('Error: ${state.error}'));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
