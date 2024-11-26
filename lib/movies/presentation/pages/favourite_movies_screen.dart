import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/presentation/movie/movie_bloc.dart';
import 'package:movie_app/movies/presentation/movie/movie_event.dart';
import 'package:movie_app/movies/presentation/movie/movie_state.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

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
              print("The retrieve movies is : ${state.favoriteMovies}");
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
              return Center(child: Text("No favorites found."));
            }
          },
        ),
      ),
    );
  }

  // Widget to build each movie item
  Widget _buildMovieItem(BuildContext context, MovieEntity movie) {
    return ListTile(
      leading: movie.posterPath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '$basePosterUrl${movie.posterPath}',
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
            )
          : const SizedBox(
              width: 50,
              height: 75,
              child: Icon(Icons.image),
            ),
      title: Text(
        movie.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        movie.releaseDate.isNotEmpty
            ? movie.releaseDate
            : 'Unknown release date',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: () {
          context.read<MovieBloc>().add(RemoveFromFavourites(movie: movie));
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetails,
          arguments: movie,
        );
      },
    );
  }
}
