import 'package:flutter/material.dart';
import 'package:movie_app/movies/presentation/widgets/movie_home.dart'; // Import MovieCarouselWidget
import 'package:movie_app/movies/presentation/widgets/trending_movies_widget.dart';
import 'package:movie_app/movies/presentation/widgets/tvshows_widget.dart';
import 'package:movie_app/movies/presentation/widgets/upcoming_movie_section.dart'; // Import TrendingMoviesWidget

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  // Define a method to handle the button press (e.g., opening a drawer)
  void _onMenuButtonPressed(BuildContext context) {
    Scaffold.of(context)
        .openDrawer(); // Open the drawer when the menu button is pressed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a Drawer to the Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header (optional)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
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
                  MaterialPageRoute(builder: (context) => const MovieScreen()),
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
                      builder: (context) => const TrendingMoviesWidget()),
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
                      builder: (context) => const TvshowsWidget()),
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
                      builder: (context) => const UpComingMoviesWidget()),
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
                MovieCarouselWidget(), // Direct call to MovieCarouselWidget

                // Trending Movies Section
                TrendingMoviesWidget(), // Direct call to TrendingMoviesWidget
                // For upcoming movies
                UpComingMoviesWidget(),
                // Showing here all the series
                TvshowsWidget(),
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
