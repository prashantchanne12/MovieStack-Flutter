import 'package:flutter/material.dart';

import '../constants.dart';

Column searchPlaceholder() {
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              color: kDarkBlue2,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          Container(
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: kDarkBlue2,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: kDarkBlue2,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
