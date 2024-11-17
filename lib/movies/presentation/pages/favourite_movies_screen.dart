import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieError) {
          return Center(child: Text('Error: ${state.error}'));
        }

        // Show favorite movies in a list if MovieDone state
        if (state is MovieDone) {
          final favoriteMovies = state.favoriteMovies;
          print("In the UI : ${favoriteMovies}");
          // If no favorite movies
          if (favoriteMovies.isEmpty) {
            return const Center(child: Text('No favorite movies added.'));
          }

          // Display favorite movies in a ListView
          return Scaffold(
            appBar: AppBar(title: const Text('Favorite Movies')),
            body: ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];

                return ListTile(
                  leading: Image.network(
                    '$basePosterUrl${movie.posterPath}',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate ?? 'No release date'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      // Logic for removing from favorites if needed
                      // Here you can dispatch RemoveFromFavourites event
                    },
                  ),
                  onTap: () {
                    // Navigate to movie details page
                    Navigator.pushNamed(context, '/all-movie-details',
                        arguments: movie);
                  },
                );
              },
            ),
          );
        }

        // Default empty state
        return const SizedBox.shrink();
      },
    );
  }
}
