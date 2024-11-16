import 'package:flutter/material.dart';
// import 'package:movie_app/movies/data/data_models/movie_models.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<MovieEntity> results;
  const SearchResultsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: Colors.transparent,
      ),
      body: results.isEmpty
          ? const Center(child: Text('No results found'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final movie = results[index];
                return ListTile(
                  title: Text(movie.title), // Display movie title
                  subtitle: Text(movie.overview), // Display movie description
                  leading: movie.posterPath != null
                      ? Image.network(
                          'basePosterUrl${movie.posterPath}')
                      : const Icon(Icons.movie),
                );
              },
            ),
    );
  }
}
