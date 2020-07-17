import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/widgets/swiper.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesBloc moviesBloc = MoviesProvider.of(context);
    DetailsBloc detailsBloc = DetailsPageProvider.of(context);
    moviesBloc.fetchTopRatedMovies(1);
    moviesBloc.fetchPopularMovies(1);
    moviesBloc.fetchUpcomingMovies(1);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            heading(title: 'Popular'),
            SizedBox(height: 10.0),
            swiper(
                stream: moviesBloc.popularMovies,
                detailsBloc: detailsBloc,
                isMovie: true),
            SizedBox(height: 10.0),
            heading(title: 'Top Rated'),
            SizedBox(height: 10.0),
            swiper(
                stream: moviesBloc.topRatedMovies,
                detailsBloc: detailsBloc,
                isMovie: true),
            SizedBox(height: 10.0),
            heading(title: 'Now Playing'),
            SizedBox(height: 10.0),
            swiper(
                stream: moviesBloc.upcomingMovies,
                detailsBloc: detailsBloc,
                isMovie: true),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget heading({@required String title}) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '$title',
        style: TextStyle(
          color: kLightGrey,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
