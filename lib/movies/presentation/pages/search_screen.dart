import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/app_routes.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie/movie_state.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    context.read<MovieBloc>().add(SearchMovies(query: query));
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search for a movie...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // Results display
            Expanded(
              child: BlocProvider(
                create:(context) => getIt<MovieBloc>(),
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each movie item
  Widget _buildMovieItem(BuildContext context, MovieEntity movie) {
    return ListTile(
      leading: movie.posterPath != null
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
