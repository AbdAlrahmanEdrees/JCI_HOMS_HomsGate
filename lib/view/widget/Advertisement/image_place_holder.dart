import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.beige.withValues(alpha:0.35),
      child: Center(
        child: Icon(
          Icons.directions_car_filled,
          size: 36.sp,
          color: AppColors.brown,
        ),
      ),
    );
  }
}
