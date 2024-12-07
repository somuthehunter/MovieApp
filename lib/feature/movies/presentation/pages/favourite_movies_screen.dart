import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/utilities/logger.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_event.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_state.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: BlocProvider(
        create: (context) => getIt<MovieBloc>(),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieDone) {
              Logger.info("The retrieve movies is : ${state.favoriteMovies}");
              return ListView.builder(
                itemCount: state.favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.favoriteMovies[index];
                  return ListTile(
                    title: Text(movie.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context
                            .read<MovieBloc>()
                            .add(RemoveFromFavourites(movie: movie));
                      },
                    ),
                  );
                },
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text("No favorites found."));
            }
          },
        ),
      ),
    );
  }
}
