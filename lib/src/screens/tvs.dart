import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/blocs/tv_bloc.dart';
import 'package:movie_stack/src/blocs/tv_provider.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';

import '../constants.dart';
import 'details_page.dart';

class TV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailsBloc detailsBloc = DetailsPageProvider.of(context);
    TvBloc tvBloc = TvProvider.of(context);
    tvBloc.fetchPopularTv(1);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            heading(title: 'Popular'),
            swiper(stream: tvBloc.popularTv, detailsBloc: detailsBloc),
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
              TvModel model = TvModel.fromJson(snapshot.data[index]);
              return GestureDetector(
                onTap: () {
                  TvModel tvModel = TvModel.fromJson(snapshot.data[index]);
                  openDetailsScreen(context, tvModel.id, true, detailsBloc);
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
                          model.name,
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
