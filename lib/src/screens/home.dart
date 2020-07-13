import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_stack/src/blocs/home_bloc.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/trending_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:movie_stack/src/widgets/trending_carousel.dart';

MoviesApiProvider moviesApiProvider = MoviesApiProvider();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    homeBloc.fetchTrendingMovies();
//    homeBloc.fetchTrendingTV();

    homeBloc.fetchTrending();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[trendingCarousel()],
        ),
      ),
    );
  }

  trendingCarousel() {
    return Container(
      height: 250.0,
      child: StreamBuilder(
        stream: homeBloc.trending,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              TrendingModel trendingModel =
                  TrendingModel.fromJson(snapshot.data[index]);
              bool isMovie = trendingModel.media_type == 'movie';
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(
                        '$kImageUrl${trendingModel.backdrop_path}'),
                    fit: BoxFit.cover,
                  ),
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
