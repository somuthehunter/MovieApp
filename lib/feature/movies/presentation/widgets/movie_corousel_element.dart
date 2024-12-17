import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_bloc.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_event.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_state.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';

class MovieCorouselElement extends StatelessWidget {
  final Movie movie;
  final List<Movie> favMovies;
  const MovieCorouselElement(
      {super.key, required this.movie, required this.favMovies});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isAdded = ValueNotifier(false);

    return Stack(
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
              return Utilities.buildShimmerEffect(
                  height: MediaQuery.of(context).size.height * 0.5);
            },
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),

        // Favorite Icon (Love Icon) on top left
        BlocListener<FavouriteBloc, FavouriteState>(
          listener: (context, state) {
            if (state is FavouriteMovieAdded && state.movie.id == movie.id) {
              isAdded.value = true;
              context.read<FavouriteBloc>().add(ResetEvent());
            }
          },
          child: ValueListenableBuilder(
              valueListenable: isAdded,
              builder: (context, value, child) {
                return Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: (value || favMovies.contains(movie))
                          ? Colors.red // Show red if it's a favorite
                          : Colors.grey, // Otherwise, show grey
                    ),
                    iconSize: 30,
                    onPressed: () {
                      // Toggle favorites on icon tap
                      //if (favoriteMovieIds.value.contains(movie.id)) {
                      // context
                      //     .read<FavouriteBloc>()
                      //     .add(RemoveFromFavourite(movie: movie));
                      // favoriteMovieIds.remove(movie.id);
                      // } else
                      // {
                      context
                          .read<FavouriteBloc>()
                          .add(AddToFavourite(movie: movie));
                      //}
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
