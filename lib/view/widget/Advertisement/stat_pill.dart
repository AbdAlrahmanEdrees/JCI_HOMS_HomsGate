
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';

class StatPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const StatPill({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.beige.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.beige, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.brown),
          SizedBox(width: 6.w),
          Text(label, style: AppTextStyles.h16b),
        ],
      ),
    );
  }
}