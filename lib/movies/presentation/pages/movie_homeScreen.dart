// lib/presentation/screens/movie_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/service_container.dart'; // For dependency injection
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';
// import 'package:movie_app/movies/presentation/widgets/movie_carousel_widget.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MovieBloc>()
        ..add(GetMovies())
        ..add(GetTrendingMovies())
        ..add(UpComingMovies()),
      child: Scaffold(
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDone) {
              if (state.movies.isEmpty &&
                  state.trendingMovies.isEmpty &&
                  state.upComingMovies.isEmpty) {
                return const Center(child: Text('No movies available'));
              }
              return MovieCarouselWidget(
                movies: state.movies, //general movie
                trendingMovies: state.trendingMovies, //trending movies
                upcomingMovies: state.upComingMovies, // upcoming movies
              );
            } else if (state is MovieError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
