import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/utilities/utilities.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_bloc.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_event.dart';
import 'package:movie_app/feature/favourite/presentation/bloc/favourite_state.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: BlocProvider(
        create: (context) => getIt<FavouriteBloc>()..add(GetFavourite()),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            switch (state) {
              case FavouriteLoading _:
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Utilities.showLoadingBanner(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.5),
                );
              case FavouriteMovieLoaded _:
                return ListView.builder(
                  itemCount: state.favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.favoriteMovies[index];
                    return ListTile(
                      title: Text(movie.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // context
                          //     .read<Favou>()
                          //     .add(RemoveFromFavourites(movie: movie));
                        },
                      ),
                    );
                  },
                );
              case FavoriteMoviesError _:
                return Center(child: Text(state.error));

              default:
                return const Center(child: Text("No favorites found."));
            }
          },
        ),
      ),
    );
  }
}
