import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/movie_details_bloc.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/movie_details_model.dart';

var children;
int count;

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    children = <Widget>[];
    count = 0;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              stream(),
            ],
          ),
        ),
      ),
    );
  }

  stream() {
    return StreamBuilder(
      stream: movieDetailsBloc.movie,
      builder:
          (BuildContext context, AsyncSnapshot<MovieDetailsModel> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: double.infinity,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: kDarkBlue2,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
        }
        MovieDetailsModel movieDetailsModel = snapshot.data;
        movieDetailsModel.genres.forEach((element) {
          if (count <= 3) {
            children.add(createGenres(element['name']));
          }
          count = count + 1;
        });
        return Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  '$kImageUrl${movieDetailsModel.poster_path}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${movieDetailsModel.title}',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 11.0),
                            alignment: Alignment.centerLeft,
                            child: CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 4.0,
                              animation: true,
                              percent: movieDetailsModel.vote_average / 10,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: kAccentColor,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '${movieDetailsModel.vote_average * 10} %',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${movieDetailsModel.release_date}'.substring(0, 4),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.graphic_eq,
                        color: kAccentColor,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Row(
                        children: children,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Text(
                    'The Plot',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                  child: Text(
                    '${movieDetailsModel.overview}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget createGenres(String text) {
    return Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: kAccentColor, width: 1.0),
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
