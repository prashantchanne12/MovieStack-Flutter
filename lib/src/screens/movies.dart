import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/movies_bloc.dart';
import 'package:movie_stack/src/blocs/movies_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';

import 'details_page.dart';

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
            heading(title: 'Top Rated'),
            SizedBox(height: 10.0),
            swiper(stream: moviesBloc.topRatedMovies, detailsBloc: detailsBloc),
            SizedBox(height: 10.0),
            heading(title: 'Popular'),
            SizedBox(height: 10.0),
            swiper(stream: moviesBloc.popularMovies, detailsBloc: detailsBloc),
            SizedBox(height: 10.0),
            heading(title: 'Now Playing'),
            swiper(stream: moviesBloc.upcomingMovies, detailsBloc: detailsBloc),
          ],
        ),
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

  Widget swiper({@required var stream, @required DetailsBloc detailsBloc}) {
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
              MovieModel model = MovieModel.fromJson(snapshot.data[index]);
              return GestureDetector(
                onTap: () {
                  MovieModel movieModel =
                      MovieModel.fromJson(snapshot.data[index]);
                  openDetailsScreen(context, movieModel.id, true, detailsBloc);
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
                          model.title,
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
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.stars,
                            color: kAccentColor,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${model.vote_average}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
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
}
