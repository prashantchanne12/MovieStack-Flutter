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
