import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart';
import 'package:movie_app/core/constants/constant.dart';
import 'package:movie_app/movies/domain/entity/movie_entity.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';
// import 'package:movie_app/movies/presentation/widgets/movie_carousel_widget.dart'; // Adjust this import

class TrendingMoviesWidget extends StatelessWidget {
  const TrendingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()
        ..add(GetTrendingMovies()), // Trigger the GetTrendingMovies event
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDone) {
            if (state.trendingMovies.isEmpty) {
              return const Center(child: Text('No trending movies available'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Trending Movies',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.trendingMovies.map((movie) {
                        return buildMovieThumbnail(context, movie);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink(); // Default empty state
        },
      ),
    );
  }

  // Helper method to build each movie thumbnail
  Widget buildMovieThumbnail(BuildContext context, MovieEntity movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/all-movie-details', arguments: movie);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '$basePosterUrl${movie.posterPath}',
            width: 120,
            height: 180,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      ),
    );
  }
}
