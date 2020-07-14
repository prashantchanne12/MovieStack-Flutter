import 'package:flutter/material.dart';

import '../constants.dart';

Column castLoadingPlaceholder({@required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        width: MediaQuery.of(context).size.width - 40,
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
        width: MediaQuery.of(context).size.width - 40,
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
        width: MediaQuery.of(context).size.width - 80,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ],
  );
}
