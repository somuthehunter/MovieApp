import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_bloc.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_event.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_state.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_event.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/movies/presentation/widgets/movie_corousel_element.dart';

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()..add(GetMovies()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          switch (state) {
            case MovieLoading _:
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Utilities.showLoadingBanner(
                    context: context,
                    height: MediaQuery.of(context).size.height * 0.5),
              );

            case MovieDone _:
              if (state.movies.isEmpty) {
                return const Center(child: Text('No movies available'));
              }
              return MovieCarousel(movies: state.movies);
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

/// MovieCarousel widget to display the carousel slider
class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MovieCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    // Track favorite movies by their IDs

    double screenHeight = MediaQuery.of(context).size.height;
    List<Movie> favMovies = [];
    return BlocProvider(
      create: (context) => getIt<FavouriteBloc>()..add(GetFavourite()),
      child: BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteMovieLoaded) {
            favMovies = state.favoriteMovies;
          }
        },
        child: SizedBox(
          height: screenHeight * 0.5,
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
                    context
                        .read<FavouriteBloc>()
                        .add(AddToFavourite(movie: movie));
                  },
                  child:
                      MovieCorouselElement(movie: movie, favMovies: favMovies));
            },
            options: CarouselOptions(
              height: screenHeight * 0.5,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              autoPlayInterval: const Duration(seconds: 5),
            ),
          ),
        ),
      ),
    );
  }
}
