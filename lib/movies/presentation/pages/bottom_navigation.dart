// lib/presentation/screens/movie_home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_event.dart';
import 'package:movie_app/movies/presentation/bloc/navigation/navigation_state.dart';
import 'package:movie_app/movies/presentation/pages/favourite_movies_screen.dart';
import 'package:movie_app/movies/presentation/pages/movie_home_screen.dart';
import 'package:movie_app/movies/presentation/pages/search_screen.dart';
// import 'package:movie_app/movies/presentation/widgets/movie_screen.dart';

class BottomNavigation extends StatelessWidget {
  final List<Widget> pages = [
    const HomeScreen(), // Main MovieScreen widget with movie posters and trending movies
    SearchScreen(), // Placeholder for Search Screen
    // ignore: prefer_const_constructors
    FavoriteMoviesScreen(), // Placeholder for Favorites Screen
  ];

  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return pages[state.selectedIndex]; // Display selected page
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              backgroundColor:
                  Colors.black.withOpacity(0.8), // Adjust background color
              currentIndex: state.selectedIndex,
              onTap: (index) {
                context
                    .read<NavigationBloc>()
                    .add(ChangeNavigationEvent(index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.yellowAccent),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.yellowAccent),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: Colors.yellowAccent),
                  label: 'Favorites',
                ),
              ],
              selectedItemColor: Colors.yellowAccent,
              unselectedItemColor: Colors.white70,
              showUnselectedLabels: true,
            );
          },
        ),
      ),
    );
  }
}
