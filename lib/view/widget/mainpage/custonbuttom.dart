import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/textstyles.dart';

import '../../../core/constanat/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function() onpress;
  final String title;
  const CustomButton({super.key, required this.onpress, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        decoration: BoxDecoration(
          color: AppColors.beige,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Text(title, style: AppTextStyles.h15b),
      ),
    );
  }
}
