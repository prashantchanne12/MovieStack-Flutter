import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/home_bloc.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/blocs/home_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/trending_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/movies_api_provider.dart';
import 'package:movie_stack/src/resources/open_details_screen.dart';
import 'package:movie_stack/src/screens/movies.dart';
import 'package:movie_stack/src/screens/search.dart';
import 'package:movie_stack/src/screens/test.dart';
import 'package:movie_stack/src/screens/tvs.dart';
import 'package:movie_stack/src/widgets/trending_loading_placeholder.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

MoviesApiProvider moviesApiProvider = MoviesApiProvider();
var model;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = HomeProvider.of(context);
    final detailsBloc = DetailsPageProvider.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            title: Text(
              'MovieStack',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: kAccentColor,
                letterSpacing: 1.4,
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Trending',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Movies',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'TV',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: kPrimaryColor,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[trendingCarousel(bloc, detailsBloc)],
            ),
            Movies(),
            TV(),
          ],
        ),
      ),
    );
  }

  trendingCarousel(HomeBloc bloc, DetailsBloc detailsBloc) {
    return Column(
      children: <Widget>[
        heading(title: 'Trending'),
        trendingSwiper(bloc, detailsBloc),
        SizedBox(height: 10.0),
        heading(title: 'Movies'),
        swiper(stream: bloc.movies, isMovie: true, detailsBloc: detailsBloc),
        SizedBox(height: 10.0),
        heading(title: 'TV Shows'),
        swiper(stream: bloc.tv, isMovie: false, detailsBloc: detailsBloc),
        SizedBox(
          height: 10.0,
        ),
//        tvHeading(),
      ],
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

  Widget trendingSwiper(HomeBloc bloc, DetailsBloc detailsBloc) {
    return Container(
      height: 260.0,
      child: StreamBuilder(
        stream: bloc.trending,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return loadingPlaceholder(context);
          }
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              TrendingModel trendingModel =
                  TrendingModel.fromJson(snapshot.data[index]);
              bool isMovie = trendingModel.media_type == 'movie';
              return GestureDetector(
                onTap: () {
                  openDetailsScreen(
                      context, trendingModel.id, isMovie, detailsBloc);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                '$kImageUrl${trendingModel.backdrop_path}',
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
                      ),
                      bottomInfo(isMovie, trendingModel),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data.length,
            viewportFraction: 0.9,
            scale: 0.8,
            loop: true,
            autoplay: true,
            autoplayDelay: 10000,
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  Widget bottomInfo(bool isMovie, TrendingModel trendingModel) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              isMovie ? trendingModel.title : trendingModel.name,
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
                  progressColor: kAccentColor,
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
    );
  }

  Widget swiper(
      {@required Stream<List<dynamic>> stream,
      @required bool isMovie,
      @required DetailsBloc detailsBloc}) {
    return Container(
      height: 250.0,
      padding: EdgeInsets.only(left: 5.0),
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return moviesCarouselLodingPlaceholder();
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (isMovie) {
                model = MovieModel.fromJson(snapshot.data[index]);
              } else {
                model = TvModel.fromJson(snapshot.data[index]);
              }
              return GestureDetector(
                onTap: () {
                  MovieModel movieModel =
                      MovieModel.fromJson(snapshot.data[index]);
                  openDetailsScreen(
                      context, movieModel.id, isMovie, detailsBloc);
                },
                child: Container(
                  height: 220.0,
                  padding: EdgeInsets.only(left: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: CachedNetworkImage(
                            imageUrl: '$kImageUrl${model.poster_path}',
                            placeholder: (context, url) {
                              return Container(
                                height: 200.0,
                                width: 140.0,
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
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: 120.0,
                        child: Text(
                          isMovie ? model.title : model.name,
                          style: TextStyle(
                            color: kLightGrey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RatingBar(
                        initialRating: model.vote_average / 2,
                        itemSize: 13.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: kAccentColor,
                        ),
                        onRatingUpdate: null,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data.length,
          );
        },
      ),
    );
  }
}
