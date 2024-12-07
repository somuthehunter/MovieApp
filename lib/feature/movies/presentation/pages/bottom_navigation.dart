import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/feature/movies/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:movie_app/feature/movies/presentation/bloc/navigation/navigation_event.dart';
import 'package:movie_app/feature/movies/presentation/bloc/navigation/navigation_state.dart';
import 'package:movie_app/feature/movies/presentation/pages/favourite_movies_screen.dart';
import 'package:movie_app/feature/movies/presentation/pages/movie_home_screen.dart';
import 'package:movie_app/feature/movies/presentation/pages/search_screen.dart';

class BottomNavigation extends StatelessWidget {
  final List<Widget> pages = [
    const HomeScreen(),
    SearchScreen(),
    const FavoriteMoviesScreen()
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
                  icon: Icon(Icons.home, color: AppColors.primary),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: AppColors.primary),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: AppColors.primary),
                  label: 'Favorites',
                ),
              ],
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.white70,
              showUnselectedLabels: true,
            );
          },
        ),
      ),
    );
  }
}
