import 'package:flutter/cupertino.dart';

import '../constants.dart';

Column loadingPlaceholder(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        height: 210,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Container(
        height: 10,
        alignment: Alignment.bottomLeft,
        width: 50.0,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      Container(
        height: 10,
        alignment: Alignment.bottomLeft,
        width: 50.0,
        decoration: BoxDecoration(
          color: kDarkBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ],
  );
}
