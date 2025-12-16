import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constanat/colors.dart';

class CustomDataDetails extends StatelessWidget {
  final String imageurl;
  final String title;
  final String ammount;
  const CustomDataDetails({
    super.key,
    required this.imageurl,
    required this.title,
    required this.ammount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              ammount,
              style: TextStyle(
                color: AppColors.greencolor,
                fontFamily: "Tejwal",
              ),
              textDirection: TextDirection.rtl,
            ),

            SizedBox(width: 50),
            Container(
              alignment: Alignment.topRight,
              width: 150.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15.sp, fontFamily: "Tejwal"),
                  ),
                  SizedBox(width: 5.sp),
                  Image.asset(
                    imageurl,
                    color: AppColors.greencolor,
                    width: 15.sp,
                    height: 15.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
