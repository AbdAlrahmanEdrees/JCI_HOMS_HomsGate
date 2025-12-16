import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGallaryPhoto extends StatelessWidget {
  final File imageurl;
  final void Function()? removephoto;
  const CustomGallaryPhoto({
    super.key,
    required this.imageurl,
    required this.removephoto,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 105.sp,
          height: 105.sp,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.file(imageurl, fit: BoxFit.cover),
        ),
        Positioned(
          top: 10,
          left: 105,
          child: InkWell(
            onTap: removephoto,
            child: Container(
              width: 15.sp,
              height: 15.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(Icons.remove, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
