import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/tv_bloc.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/open_details_screen.dart';
import 'package:movie_stack/src/widgets/swiper.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';

import '../constants.dart';
import 'all_movies.dart';
import 'details_page.dart';

class TV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailsBloc detailsBloc = DetailsPageProvider.of(context);
    TvBloc tvBloc = TvProvider.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              heading(
                  title: 'Airing Today',
                  context: context,
                  which: 1,
                  tvBloc: tvBloc),
              SizedBox(height: 10.0),
              swiper(
                  stream: tvBloc.arrivingTodayTv,
                  detailsBloc: detailsBloc,
                  isMovie: false),
              SizedBox(height: 10.0),
              heading(
                  title: 'Popular', context: context, which: 2, tvBloc: tvBloc),
              SizedBox(height: 10.0),
              swiper(
                  stream: tvBloc.popularTv,
                  detailsBloc: detailsBloc,
                  isMovie: false),
              SizedBox(height: 20.0),
              heading(
                  title: 'Top Rated',
                  context: context,
                  which: 3,
                  tvBloc: tvBloc),
              SizedBox(height: 10.0),
              swiper(
                  stream: tvBloc.topRatedTv,
                  detailsBloc: detailsBloc,
                  isMovie: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget heading(
      {@required BuildContext context,
      @required String title,
      @required TvBloc tvBloc,
      @required which}) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
      alignment: Alignment.centerLeft,
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
              tvBloc.fetchTvs(1, which);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllMovies(
                          isMovie: false,
                          which: which,
                        )),
              );
            },
            child: Text(
              'See all',
              style: TextStyle(
                color: kAccentColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
