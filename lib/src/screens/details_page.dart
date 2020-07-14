import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_stack/src/blocs/details_page_bloc.dart';
import 'package:movie_stack/src/blocs/details_page_provider.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/cast_model.dart';
import 'package:movie_stack/src/widgets/details_page_loading_placeholder.dart';
import 'package:movie_stack/src/widgets/trending_loading_placeholder.dart';
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
    count = 0;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              stream(detailsBloc),
              castStream(detailsBloc),
            ],
          ),
        ),
      ),
    );
  }

  stream(DetailsBloc detailsBloc) {
    return StreamBuilder(
      stream: detailsBloc.details,
      builder: (BuildContext context, AsyncSnapshot<DetailsModel> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: kDarkBlue2,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
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
                plot(model: detailsModel),
                Container(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    'Cast',
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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

  castStream(DetailsBloc detailsBloc) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 5.0),
      height: 200.0,
      child: StreamBuilder(
        stream: detailsBloc.cast,
        builder: (BuildContext context, AsyncSnapshot<CastModel> snapshot) {
          if (!snapshot.hasData) {
            return castLoadingPlaceholder(context: context);
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

  Container createPoster(
      {@required BuildContext context, @required DetailsModel model}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          '$kImageUrl${model.poster_path}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Row createTitle(
      {@required DetailsModel model, @required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 150.0,
          padding: EdgeInsets.only(left: 10.0),
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
      padding: EdgeInsets.only(left: 10.0),
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
    );
  }

  Column plot({@required DetailsModel model}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 15.0),
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
          padding: EdgeInsets.only(left: 10.0, top: 5.0),
          child: Text(
            '${model.overview}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
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
