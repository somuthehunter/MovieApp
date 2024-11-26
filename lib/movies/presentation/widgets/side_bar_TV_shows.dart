import 'package:flutter/material.dart';
import 'package:movie_app/movies/presentation/pages/movie_homeScreen.dart';

import 'package:movie_app/movies/presentation/widgets/side_bar_movieScreen_widget.dart';
import 'package:movie_app/movies/presentation/widgets/side_bar_trendingmovieScreen_widget.dart';

import 'package:movie_app/movies/presentation/widgets/side_bar_upcoming_movies.dart';

import 'package:movie_app/movies/presentation/widgets/tvshows_widget.dart';
// Import TrendingMoviesWidget

class SideBarTvShows extends StatelessWidget {
  const SideBarTvShows({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tv Shows"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MovieScreen(),
              ),
              (route) => false,
            )
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Open the drawer when the menu button is pressed
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      // Add an end drawer to the Scaffold for the menu
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SideBarMoviescreenWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Trending Movies'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SideBarTrendingmoviescreenWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TvshowsWidget()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.upcoming),
              title: const Text('Upcoming Movies'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SideBarUpcomingMovieWidget()),
                );
              },
            ),
          ],
        ),
      ),
      body: const TvshowsWidget(),
    );
  }
}
