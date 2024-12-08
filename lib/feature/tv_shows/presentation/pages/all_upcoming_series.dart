import 'package:flutter/material.dart';
import 'package:movie_app/feature/tv_shows/domain/entities/tv_show_entity.dart';
import 'package:movie_app/feature/tv_shows/presentation/widgets/tv_show_detail.dart';

class AllUpcomingSeries extends StatelessWidget {
  final List<TVShow> shows;

  const AllUpcomingSeries({super.key, required this.shows});

  @override
  Widget build(BuildContext context) {
    return TVShowDetail(show: shows, pageTitle: "All Upcoming Series");
  }
}
