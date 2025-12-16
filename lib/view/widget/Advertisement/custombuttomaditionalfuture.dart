import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constanat/colors.dart';

class CustomButtomAditional extends StatelessWidget {
  final bool varname;
  final String label;
  final void Function() onTap;
  const CustomButtomAditional({
    super.key,
    required this.varname,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 35),
        decoration: BoxDecoration(
          color: varname ? AppColors.greencolor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greencolor, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: "Tejwal",
            fontWeight: FontWeight.bold,
            color: varname ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
