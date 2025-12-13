import 'dart:js';

import 'package:flutter/material.dart';
//
Widget getCircleIndicator() {
  return Center(
    child: CircularProgressIndicator(
      //valueColor: new AlwaysStoppedAnimation<Color>(Colors.accents),

    ),
  );
}


Widget noInternetConnection() {
  return Center(
      child: Container(
        child: Text('No Internet connection available'),
      ));
}

BoxDecoration myBoxBorder(double radius) {
  return BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

/*Widget setSVGIcon(String assetName, String semanticsLabel) {
  Widget svgIcon = SvgPicture.asset(
    assetName,
    semanticsLabel: semanticsLabel,
  );
  return svgIcon;
}*/

