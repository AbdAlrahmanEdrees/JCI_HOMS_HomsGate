import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constanat/colors.dart';

class CustomCategory extends StatelessWidget {
  final String imageurl;
  final String title;
  const CustomCategory({
    super.key,
    required this.imageurl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      width: 75.sp,
      height: 75.sp,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.brown,width: 1),
        image: DecorationImage(image: AssetImage(imageurl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10.sp),
        // color: AppColors.greencolor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: "TejwalBold",
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
