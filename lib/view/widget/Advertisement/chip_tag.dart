
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';

class ChipTag extends StatelessWidget {
  final IconData icon;
  final String label;
  const ChipTag({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
      backgroundColor: AppColors.beige.withValues(alpha:0.5),
      shape: StadiumBorder(side: BorderSide(color: AppColors.beige, width: 1)),
      avatar: Icon(icon, size: 18.sp, color: AppColors.brown),
      label: Text(label, style: AppTextStyles.h16b),
    );
  }
}