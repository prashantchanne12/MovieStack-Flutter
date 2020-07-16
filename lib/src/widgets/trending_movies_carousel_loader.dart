import 'package:flutter/material.dart';

import '../constants.dart';

Widget moviesCarouselLodingPlaceholder() {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Row(
      children: <Widget>[
        Container(
          height: 210,
          width: 140.0,
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 210,
          width: 140.0,
          decoration: BoxDecoration(
            color: kDarkBlue2,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ],
    ),
  );
}
