import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constanat/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onpress;
  const CustomButton({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(5),
        width: 300.sp,
        height: 40.sp,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(3, 4),
              blurRadius: 5,
            ),
          ],
          color: AppColors.greencolor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,

          style: TextStyle(
            color: Colors.white,
            //height: 10.sp
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
