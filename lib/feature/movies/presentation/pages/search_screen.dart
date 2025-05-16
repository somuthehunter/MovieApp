import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/feature/movies/domain/entity/movie.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_event.dart';
import 'package:movie_app/feature/movies/presentation/bloc/movie/movie_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  // TextEditingController for the search input field
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        actions: [
          // Clear Button to clear the search input
          IconButton(
            onPressed: () {
              _searchController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<MovieBloc>(),
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: AppColors.primary,
                    controller: _searchController,
                    onChanged: (query) {
                      if (query.isNotEmpty) {
                        context
                            .read<MovieBloc>()
                            .add(SearchMovies(query: query));
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a movie...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Adds rounded corners
                        borderSide: const BorderSide(
                          color: Colors.grey, // Default border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: AppColors.primary, // Border color when focused
                          width: 2.0, // Optional: Border width when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.grey, // Border color when not focused
                        ),
                      ),
                    ),
                  ),
                );
              }),
              // Results display
              Expanded(
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else if (state is MovieSearchError) {
                      return Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is MovieSearchSuccess) {
                      final searchResults = state.searchResults;

                      if (searchResults.isEmpty) {
                        return const Center(
                          child: Text('No results found.'),
                        );
                      }

                      return ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = searchResults[index];
                          return _buildMovieItem(context, movie);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Start typing to search for movies!'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build each movie item
  Widget _buildMovieItem(BuildContext context, Movie movie) {
    return ListTile(
      leading: movie.posterPath.isNotEmpty
          ? ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Optional: Adds rounded corners
              child: Image.network(
                '$basePosterUrl${movie.posterPath}',
                width: 50,
                height: 75, // Fixed height to constrain the image
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
        movie.overview,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
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
