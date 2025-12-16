import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      width: double.infinity,
      height: 50.sp,
      decoration: BoxDecoration(color:AppColors.blue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ad_details".tr(),
            style: AppTextStyles.h13b
          ),
          Row(
            children: [
              Text("required_fields".tr(), style: AppTextStyles.h15b,),
              Icon(Icons.star, color: Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }
}
