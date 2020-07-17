import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/tv_bloc.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/open_details_screen.dart';
import 'package:movie_stack/src/widgets/swiper.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';

import '../constants.dart';
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
              heading(title: 'Airing Today'),
              swiper(
                  stream: tvBloc.arrivingTodayTv,
                  detailsBloc: detailsBloc,
                  isMovie: false),
              SizedBox(height: 10.0),
              heading(title: 'Popular'),
              swiper(
                  stream: tvBloc.popularTv,
                  detailsBloc: detailsBloc,
                  isMovie: false),
              SizedBox(height: 10.0),
              heading(title: 'Top Rated'),
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

  Widget heading({@required String title}) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 13.0, bottom: 10.0),
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

// TODO: 2. TabController - to call fetch before loading tab
// TODO: 3. See all
// TODO: 4. Smooth
// TODO: 5. remove cached to network if file size too much
// TODO: 6. add images, trailers
