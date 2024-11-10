import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart'; // For dependency injection
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel slider package
import 'package:movie_app/movies/domain/entity/movie_entity.dart'; // Import MovieEntity

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MovieBloc>()..add(GetMovies()), // Trigger the GetMovies event

      child:
          // General Movies Section (Movie Carousel)
          BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDone) {
            if (state.movies.isEmpty) {
              return const Center(child: Text('No movies available'));
            }
            return MovieCarousel(movies: state.movies); // Pass movies list
          } else if (state is MovieError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink(); // Default empty state
        },
      ),
    );
  }
}

// MovieCarousel widget to display the carousel slider
class MovieCarousel extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieCarousel({super.key, required this.movies});

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
            child: Stack(
              key: ValueKey(movie.id),
              children: [
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
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow, // Star color
                              size: 16,
                            ),
                            const SizedBox(
                                width: 4), // Spacing between star and rating
                            Text(
                              movie.voteAverage.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
