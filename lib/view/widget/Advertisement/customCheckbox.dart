import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/textstyles.dart';

import '../../../core/constanat/colors.dart';

class CustomCheckBox extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool value;
  final String nameofitem;
  final bool ireq;
  const CustomCheckBox({
    super.key,
    required this.onChanged,
    required this.value,
    required this.nameofitem,
    required this.ireq,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ireq
            ? SizedBox(
              width: 5.sp,
              child: Icon(Icons.star, color: Colors.yellow, size: 15),
            )
            : Container(width: 5.sp),
        SizedBox(
          width: 125.sp,
          child: Text(
            nameofitem,
            style: AppTextStyles.h15b,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // color: AppColors.greencolor,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          width: 170.sp,
          child: Center(
            child: Checkbox(
              activeColor: AppColors.blue,
              value: value,
              onChanged: onChanged
            ),
          ),
        ),
      ],
    );
  }
}