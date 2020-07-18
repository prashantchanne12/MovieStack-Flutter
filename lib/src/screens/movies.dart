import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/screens/all_movies.dart';
import 'package:movie_stack/src/widgets/swiper.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesBloc moviesBloc = MoviesProvider.of(context);
    DetailsBloc detailsBloc = DetailsPageProvider.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              heading(
                title: 'Popular',
                context: context,
                moviesBloc: moviesBloc,
                which: 1,
              ),
              SizedBox(height: 10.0),
              swiper(
                  stream: moviesBloc.popularMovies,
                  detailsBloc: detailsBloc,
                  isMovie: true),
              SizedBox(height: 15.0),
              heading(
                title: 'Top Rated',
                context: context,
                moviesBloc: moviesBloc,
                which: 2,
              ),
              SizedBox(height: 10.0),
              swiper(
                  stream: moviesBloc.topRatedMovies,
                  detailsBloc: detailsBloc,
                  isMovie: true),
              SizedBox(height: 20.0),
              heading(
                title: 'Now Playing',
                context: context,
                moviesBloc: moviesBloc,
                which: 3,
              ),
              SizedBox(height: 10.0),
              swiper(
                  stream: moviesBloc.upcomingMovies,
                  detailsBloc: detailsBloc,
                  isMovie: true),
              SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget heading({
    @required String title,
    @required BuildContext context,
    @required MoviesBloc moviesBloc,
    @required int which,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: kLightGrey,
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          GestureDetector(
            onTap: () {
              moviesBloc.fetchMovies(1, which);
              String title = '';
              switch (which) {
                case 1:
                  {
                    title = 'Popular Movies';
                    break;
                  }
                case 2:
                  {
                    title = 'Top Rated Movies';
                    break;
                  }
                case 3:
                  {
                    title = 'Now Playing Movies';
                    break;
                  }
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllMovies(
                          isMovie: true,
                          which: which,
                          title: title,
                        )),
              );
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                'See all',
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
