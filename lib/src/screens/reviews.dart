import 'package:flutter/material.dart';
import 'package:movie_stack/src/constants.dart';
import 'package:movie_stack/src/models/reviews_model.dart';

class Reviews extends StatelessWidget {
  final data;
  Reviews({@required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Reviews',
          style: TextStyle(
            color: kAccentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          ReviewsModel reviewsModel = ReviewsModel.fromJson(data[index]);
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: kDarkBlue1.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: kDarkBlue1,
                ),
              ),
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
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15.0, top: 10.0, bottom: 10.0, right: 15.0),
                    child: Text(
                      reviewsModel.content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
