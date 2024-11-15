import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Search as you wish', style: TextStyle(fontSize: 20)),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Enter movie title",
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      // Dispatch the SearchMovies event with the query
                      getIt<MovieBloc>().add(SearchMovies(query: query));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    side: const BorderSide(color: Colors.blue),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieError) {
                  return Center(
                    child: Text(state.error,
                        style: const TextStyle(color: Colors.red)),
                  );
                } else if (state is MovieSearchSuccess) {
                  if (state.searchResults.isEmpty) {
                    return const Center(
                        child: Text('No results found',
                            style: TextStyle(fontSize: 18)));
                  }

                  return ListView.builder(
                    shrinkWrap:
                        true, // Allows the ListView to take only the space it needs
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = state.searchResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox
                    .shrink(); // Return an empty widget by default
              },
            ),
          ],
        ),
      ),
    );
  }
}
