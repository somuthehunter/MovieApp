import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart'; // For dependency injection
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel slider package
import 'package:movie_app/movies/domain/entity/movie_entity.dart'; // Import MovieEntity

class TrendingMovieCarouselWidget extends StatelessWidget {
  const TrendingMovieCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()
        ..add(GetTrendingMovies()), // Trigger the GetTrendingMovies event
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDone) {
            print(state.movies);
            if (state.movies.isEmpty) {
              return const Center(child: Text('No trending movies available'));
            }
            return TrendingMovieCarousel(movies: state.movies);
          } else if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MovieBloc>().add(GetTrendingMovies());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // Default empty state
        },
      ),
    );
  }
}

// TrendingMovieCarousel widget to display the carousel slider
class TrendingMovieCarousel extends StatelessWidget {
  final List<MovieEntity> movies;

  const TrendingMovieCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.5, // Set the height explicitly here
      child: CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              // Navigate to movie details page
              Navigator.pushNamed(context, '/all-movie-details',
                  arguments: movie);
            },
            onDoubleTap: () {
              // Add to favorites on double-tap
              context.read<MovieBloc>().add(AddToFavourites(movie: movie));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${movie.title} added to favorites')),
              );
            },
            child: Stack(
              key: ValueKey(movie.id),
              children: [
                // Movie Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    '$basePosterUrl${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),

                // Favorite Icon (Love Icon) on top right
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: context.read<MovieBloc>().state is MovieDone &&
                              (context.read<MovieBloc>().state as MovieDone)
                                  .favoriteMovies
                                  .contains(movie)
                          ? Colors.red // Show red if it's a favorite
                          : Colors.grey, // Otherwise, show grey
                    ),
                    iconSize: 30,
                    onPressed: () {
                      // Add to favorites on icon tap
                      context
                          .read<MovieBloc>()
                          .add(AddToFavourites(movie: movie));
                    },
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: screenHeight * 0.5, // Keep height in CarouselOptions too
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          autoPlayInterval: const Duration(seconds: 5),
        ),
      ),
    );
  }
}