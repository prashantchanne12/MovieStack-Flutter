import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_stack/src/blocs/home_bloc.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/trending_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:movie_stack/src/widgets/trending_carousel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

MoviesApiProvider moviesApiProvider = MoviesApiProvider();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    homeBloc.fetchTrendingMovies();
//    homeBloc.fetchTrendingTV();

    homeBloc.fetchTrending();

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[trendingCarousel()],
        ),
      ),
    );
  }

  trendingCarousel() {
    return Column(
      children: <Widget>[
        heading(),
        swiper(),
      ],
    );
  }

  Container heading() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        'Trending',
        style: TextStyle(
          color: kLightGrey,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget swiper() {
    return Container(
      height: 260.0,
      child: StreamBuilder(
        stream: homeBloc.trending,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 200.0,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              TrendingModel trendingModel =
                  TrendingModel.fromJson(snapshot.data[index]);
              bool isMovie = trendingModel.media_type == 'movie';
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: '$kImageUrl${trendingModel.backdrop_path}',
                        placeholder: (context, url) {
                          return Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: kDarkBlue2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 5.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              isMovie
                                  ? trendingModel.title
                                  : trendingModel.name,
                              style: TextStyle(
                                color: kLightGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 4.0,
                                  animation: true,
                                  percent: trendingModel.vote_average / 10,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: const Color(0xff4B97C5),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${trendingModel.vote_average * 10} %',
                                  style: TextStyle(
                                    color: kLightGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: snapshot.data.length,
            viewportFraction: 0.9,
            scale: 0.8,
            loop: true,
            autoplay: false,
            autoplayDelay: 5000,
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
