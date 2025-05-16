import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_event.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_state.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_detail.dart';

class TrendingMoviesWidget extends StatelessWidget {
  final bool isTrendingMoviePage;
  const TrendingMoviesWidget({super.key, this.isTrendingMoviePage = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()..add(GetTrendingMovies()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state) {
            case MovieLoading _:
              return isTrendingMoviePage
                  ? Utilities.showGridLoading()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Utilities.showLoadingBanner(
                          context: context, height: 180),
                    );

            case MovieDone _:
              return isTrendingMoviePage
                  ? state.trendingMovies.isEmpty
                      ? const Center(
                          child: Text('No trending movies available'))
                      : MovieDetail(
                          movies: state.trendingMovies,
                          pageTitle: "Trending Movies")
                  : state.trendingMovies.isEmpty
                      ? const Text('No trending movies available')
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Trending Movies',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            AppRoutes.allTrendingMovies,
                                            arguments: state.trendingMovies);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColors.primary),
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
                                  children: state.trendingMovies.map((movie) {
                                    return Utilities.buildThumbnail(
                                        context: context, movie: movie);
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
