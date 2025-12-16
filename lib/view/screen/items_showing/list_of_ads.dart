import 'package:flutter/material.dart';

Widget buildListOfAds(List<Widget> ads) {

  return ListView.builder(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.all(12),
    itemCount: ads.length,
    itemBuilder: (context, index) {
      final ad = ads[index];
      return ad;
    },
  );
}
