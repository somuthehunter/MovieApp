import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/constants/constant.dart';
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
            // BlocProvider scoped for this widget using GetIt to get MovieBloc instance
            BlocProvider(
              create: (context) => getIt<MovieBloc>(),
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  // if (state is MovieLoading) {
                  //   return const Center(child: CircularProgressIndicator());
                  if (state is MovieError) {
                    return Center(
                        child: Text(state.error,
                            style: TextStyle(color: Colors.red)));
                  } else if (state is MovieSearchSuccess) {
                    if (state.searchResults.isEmpty) {
                      return const Center(
                          child: Text('No results found',
                              style: TextStyle(fontSize: 18)));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = state.searchResults[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  '$basePosterUrl${movie.posterPath}' ??
                                      '', // Assuming 'posterUrl' is in your model
                                  height: 100,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                movie.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
