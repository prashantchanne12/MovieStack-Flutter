import 'package:flutter/material.dart';

import '../constants.dart';

Widget seeAllLoadingPlaceholder() {
  return ListView.builder(
    itemCount: 4,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 150.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: kDarkBlue2,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10.0,
                  width: 50.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  color: kDarkBlue2,
                ),
                SizedBox(
                  height: 10.0,
                  width: 50.0,
                ),
                Container(
                  height: 10.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  color: kDarkBlue2,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
