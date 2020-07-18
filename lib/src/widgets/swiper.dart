import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/models/movie_model.dart';
import 'package:movie_stack/src/models/tv_model.dart';
import 'package:movie_stack/src/resources/open_details_screen.dart';
import 'package:movie_stack/src/widgets/trending_movies_carousel_loader.dart';

import '../constants.dart';

var model;

Widget swiper(
    {@required var stream,
    @required DetailsBloc detailsBloc,
    @required bool isMovie}) {
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
            model = isMovie
                ? MovieModel.fromJson(snapshot.data[index])
                : TvModel.fromJson(snapshot.data[index]);
            return GestureDetector(
              onTap: () {
                model = isMovie
                    ? MovieModel.fromJson(snapshot.data[index])
                    : TvModel.fromJson(snapshot.data[index]);
                openDetailsScreen(context, model.id, isMovie, detailsBloc);
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
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.stars,
                          color: kAccentColor,
                          size: 13.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${model.vote_average}',
                          style: TextStyle(
                            color: kLightGrey,
                            fontSize: 13.0,
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
