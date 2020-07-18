import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/tv_bloc.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/widgets/swiper.dart';

import '../constants.dart';
import 'all_movies.dart';

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
              String title = '';
              switch (which) {
                case 1:
                  {
                    title = 'Airing Today';
                    break;
                  }
                case 2:
                  {
                    title = 'Popular SHows';
                    break;
                  }
                case 3:
                  {
                    title = 'Top Rated Shows';
                    break;
                  }
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllMovies(
                          isMovie: false,
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
          ),
        ],
      ),
    );
  }
}
