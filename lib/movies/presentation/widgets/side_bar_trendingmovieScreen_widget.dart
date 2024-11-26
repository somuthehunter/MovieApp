import 'package:flutter/material.dart';
import 'package:movie_app/movies/presentation/pages/movie_homeScreen.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart'; // Import MovieCarouselWidget
import 'package:movie_app/movies/presentation/widgets/side_bar_TV_shows.dart';
import 'package:movie_app/movies/presentation/widgets/side_bar_movieScreen_widget.dart';
import 'package:movie_app/movies/presentation/widgets/side_bar_trendingmovieScreen_widget.dart';
import 'package:movie_app/movies/presentation/widgets/side_bar_upcoming_movie_widget.dart';
import 'package:movie_app/movies/presentation/widgets/trendingMovieCarousel.dart';
import 'package:movie_app/movies/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_app/movies/presentation/widgets/tvshows_widget.dart';
import 'package:movie_app/movies/presentation/widgets/upcoming_movie_section.dart'; // Import TrendingMoviesWidget

class SideBarTrendingmoviescreenWidget extends StatelessWidget {
  const SideBarTrendingmoviescreenWidget({super.key});

  void _onMenuButtonPressed(BuildContext context) {
    Scaffold.of(context)
        .openDrawer(); // Open the drawer when the menu button is pressed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trendings"),
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
      ),
      // Add a Drawer to the Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header (optional)
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
            // Drawer items for navigation
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                // Close the drawer and navigate to the MovieScreen widget
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
                // Close the drawer and navigate to the TrendingMoviesWidget
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
                // Close the drawer and navigate to the TvshowsWidget
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SideBarTvShows()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.upcoming),
              title: const Text('Upcoming Movies'),
              onTap: () {
                // Close the drawer and navigate to the UpComingMoviesWidget
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
      body: Stack(
        children: [
          // SingleChildScrollView with Movie sections
          const SingleChildScrollView(
            child: Column(
              children: [
                // General Movies Section (Movie Carousel)
                TrendingMovieCarouselWidget(), // Direct call to MovieCarouselWidget

                // Trending Movies Section
                TrendingMoviesWidget(), // Direct call to TrendingMoviesWidget
                // For upcoming movies
                UpComingMoviesWidget(),
                // Showing here all the series
                // TvshowsWidget(),
              ],
            ),
          ),
          // Positioned Hamburger Menu Button at the top-left corner
          Positioned(
            top: 30, // Adjust the top position as needed
            right: 20, // Adjust the left position as needed
            child: Builder(
              builder: (context) => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 2, // Border width
                  ),
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: FloatingActionButton(
                  onPressed: () =>
                      _onMenuButtonPressed(context), // Handle the button press
                  backgroundColor:
                      Colors.transparent, // Button background color
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white, // Icon color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
