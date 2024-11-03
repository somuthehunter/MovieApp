// lib/presentation/screens/movie_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/movie_bloc.dart';
// import 'package:movie_app/movies/presentation/bloc/movie_event.dart';
import 'package:movie_app/movies/presentation/bloc/movie_state.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart';
// import 'package:movie_app/presentation/widgets/movie_carousel_widget.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDone) {
            if (state.movies.isEmpty) {
              return const Center(child: Text('No movies available'));
            }
            // print("pass the trending movies : ${state.trendingMovies}");
            return MovieCarouselWidget(
              movies: state.movies,
              trendingMovies: state.movies,
              upcomingMovies: state.movies,
            );
          } else if (state is MovieError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
