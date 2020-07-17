import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/screens/details_page.dart';

openDetailsScreen(
    BuildContext context, int id, bool isMovie, DetailsBloc detailsBloc) {
  detailsBloc.fetchDetails(id, isMovie ? 'movie' : 'tv');
  detailsBloc.fetchCast(id, isMovie ? 'movie' : 'tv');
  detailsBloc.fetchReviews(id);
  detailsBloc.fetchSimilar(id, isMovie ? 'movie' : 'tv');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailsPage(
        isMovie: isMovie,
      ),
    ),
  );
}
