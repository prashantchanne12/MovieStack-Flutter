import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/cast_model.dart';
import 'package:movie_stack/src/models/reviews_model.dart';
import 'package:movie_stack/src/models/similar_content.dart';
import 'package:movie_stack/src/screens/reviews.dart';
import 'package:movie_stack/src/widgets/details_page_loading_placeholder.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/movie_details_model.dart';

var children;
int count;

class DetailsPage extends StatelessWidget {
  final bool isMovie;
  DetailsPage({@required this.isMovie});
  @override
  Widget build(BuildContext context) {
    final detailsBloc = DetailsPageProvider.of(context);
    children = <Widget>[];
    count = 1;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              headerStream(detailsBloc),
              castStream(detailsBloc),
              reviewsStream(detailsBloc),
              similarStream(context, detailsBloc),
              moreDetails(detailsBloc),
            ],
          ),
        ),
      ),
    );
  }

  headerStream(DetailsBloc detailsBloc) {
    return StreamBuilder(
      stream: detailsBloc.details,
      builder: (BuildContext context, AsyncSnapshot<DetailsModel> snapshot) {
        if (!snapshot.hasData) {
          return detailsHeaderPlaceholder(context);
        }
        DetailsModel detailsModel = snapshot.data;
        detailsModel.genres.forEach((element) {
          if (count < 3) {
            children.add(createGenres(element['name']));
          }
          count = count + 1;
        });
        return Column(
          children: <Widget>[
            createPoster(
              context: context,
              model: detailsModel,
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createTitle(model: detailsModel, context: context),
                SizedBox(
                  height: 15.0,
                ),
                genresAndRelease(model: detailsModel),
                runtime(detailsModel: detailsModel),
                plot(model: detailsModel),
              ],
            ),
          ],
        );
      },
    );
  }

  castStream(DetailsBloc detailsBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15.0, top: 20.0),
          child: Text(
            'Cast',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5.0, top: 10.0),
          height: 200.0,
          child: StreamBuilder(
            stream: detailsBloc.cast,
            builder: (BuildContext context, AsyncSnapshot<CastModel> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 40.0,
                );
              }
              return ListView.builder(
                padding: EdgeInsets.only(left: 10.0),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.cast.length,
                itemBuilder: (BuildContext context, int index) {
                  return createCast(context, index, snapshot);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget createCast(
      BuildContext context, int index, AsyncSnapshot<CastModel> snapshot) {
    return Column(
      children: <Widget>[
        Container(
          height: 140.0,
          width: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              snapshot.data.cast[index]['profile_path'] != null
                  ? '$kImageUrl${snapshot.data.cast[index]['profile_path']}'
                  : kDefaultImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 120.0,
              child: Text(
                '${snapshot.data.cast[index]['name']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 130.0,
              child: Text(
                '${snapshot.data.cast[index]['character']}',
                style: TextStyle(
                  color: kLightGrey,
                  fontSize: 13.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  reviewsStream(DetailsBloc detailsBloc) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15.0, top: 10.0),
          child: Text(
            'Reviews',
            style: TextStyle(
              fontSize: 18.0,
              color: kAccentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder(
          stream: detailsBloc.reviews,
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 40.0,
              );
            }

            if (snapshot.data.length == 0) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15.0, top: 5.0),
                child: Text(
                  'No Reviews Available',
                  style: TextStyle(
                    color: kLightGrey,
                  ),
                ),
              );
            }

            ReviewsModel reviewsModel = ReviewsModel.fromJson(snapshot.data[0]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: kDarkBlue1.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      color: kDarkBlue1,
                    )),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Text(
                        reviewsModel.author,
                        style: TextStyle(
                          color: kAccentColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Text(
                        reviewsModel.content.length < 350
                            ? reviewsModel.content
                            : reviewsModel.content.substring(0, 350) + '...',
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reviews(
                                      data: snapshot.data,
                                    )),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: kDarkBlue1),
                            ),
                          ),
                          child: Text(
                            'All Reviews',
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget similarStream(BuildContext context, DetailsBloc detailsBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
          child: Text(
            'More Like This',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 5.0,
          ),
          child: StreamBuilder(
            stream: detailsBloc.similar,
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 40.0,
                );
              }
              if (snapshot.data.length == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'N/A',
                    style: TextStyle(
                      color: kLightGrey,
                    ),
                  ),
                );
              }
              return Container(
                height: 250.0,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    SimilarContentModel similarContentModel =
                        SimilarContentModel.fromJson(snapshot.data[index]);
                    return GestureDetector(
                      onTap: () {
                        openDetailsScreen(context, similarContentModel.id,
                            isMovie, detailsBloc);
                      },
                      child: Container(
                        height: 200.0,
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
                                  imageUrl:
                                      '$kImageUrl${similarContentModel.poster_path}',
                                  placeholder: (context, url) {
                                    return Container(
                                      height: 200.0,
                                      width: 140.0,
                                      decoration: BoxDecoration(
                                        color: kDarkBlue2,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
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
                                isMovie
                                    ? similarContentModel.title
                                    : similarContentModel.name,
                                style: TextStyle(
                                  color: kLightGrey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget moreDetails(DetailsBloc detailsBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 5.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'Details',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StreamBuilder(
          stream: detailsBloc.details,
          builder:
              (BuildContext context, AsyncSnapshot<DetailsModel> snapshot) {
            DetailsModel detailsModel = snapshot.data;
            if (!snapshot.hasData) {
              return Text(
                'Loading...',
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 10.0, top: 10.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: kDarkBlue1.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(
                    color: kDarkBlue1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Release Date',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                    Text(
                      isMovie
                          ? detailsModel.release_date
                          : detailsModel.first_air_date,
                      style: TextStyle(
                        color: kLightGrey,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Original Language',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                    Text(
                      detailsModel.original_language,
                      style: TextStyle(
                        color: kLightGrey,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Votes',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                    Text(
                      '${detailsModel.vote_average} / 10',
                      style: TextStyle(
                        color: kLightGrey,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      isMovie ? 'Budget' : 'Seasons',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                    Text(
                      isMovie
                          ? '\$ ${detailsModel.budget == 0 ? 'N/A' : detailsModel.budget}'
                          : '${detailsModel.number_of_seasons}',
                      style: TextStyle(
                        color: kLightGrey,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      isMovie ? 'Revenue' : 'Episodes',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                    Text(
                      isMovie
                          ? '\$ ${detailsModel.revenue == 0 ? 'N/A' : detailsModel.revenue}'
                          : '${detailsModel.number_of_episodes}',
                      style: TextStyle(
                        color: kLightGrey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Container createPoster(
      {@required BuildContext context, @required DetailsModel model}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/img.png',
            image: '$kImageUrl${model.poster_path}',
            fit: BoxFit.cover,
          )),
    );
  }

  Row createTitle(
      {@required DetailsModel model, @required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 150.0,
          padding: EdgeInsets.only(left: 15.0),
          alignment: Alignment.centerLeft,
          child: Text(
            '${isMovie ? model.title : model.name}',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
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
                  percent: model.vote_average / 10,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: kAccentColor,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                '${model.vote_average * 10} %',
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
    );
  }

  Widget genresAndRelease({@required DetailsModel model}) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              '${isMovie ? model.release_date : model.first_air_date}'
                  .substring(0, 4),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Row(
            children: children,
          ),
        ],
      ),
    );
  }

  Container runtime({DetailsModel detailsModel}) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, top: 10.0),
      child: Text(
        '${isMovie ? detailsModel.runtime : detailsModel.episode_run_time.isNotEmpty ? detailsModel.episode_run_time[0] : 'N/A'}' +
            ' mins',
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Column plot({@required DetailsModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15.0, top: 20.0),
          child: Text(
            'The Plot',
            style: TextStyle(
              color: kAccentColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 15.0, top: 5.0),
          child: Text(
            '${model.overview}',
            style: TextStyle(
              color: const Color(0xffF5F5F5),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget createGenres(String text) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
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

  openDetailsScreen(
      BuildContext context, int id, bool isMovie, DetailsBloc detailsBloc) {
    detailsBloc.fetchDetails(id, isMovie ? 'movie' : 'tv');
    detailsBloc.fetchCast(id, isMovie ? 'movie' : 'tv');
    detailsBloc.fetchReviews(id);
    detailsBloc.fetchSimilar(id, isMovie ? 'movie' : 'tv');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          isMovie: isMovie,
        ),
      ),
    );
  }
}
