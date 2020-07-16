import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Container castLoadingPlaceholder({@required BuildContext context}) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(
      left: 20.0,
    ),
    height: 500.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          width: 300.0,
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 30.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 20.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ],
    ),
  );
}

Widget detailsHeaderPlaceholder(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Container(
        margin: EdgeInsets.only(left: 5.0, right: 10.0),
        width: 250.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Container(
        margin: EdgeInsets.only(left: 5.0, right: 10.0),
        width: 200.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      SizedBox(
        height: 200.0,
      ),
    ],
  );
}
