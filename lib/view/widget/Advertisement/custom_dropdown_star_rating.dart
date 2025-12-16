import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/dropdownStarsmodel.dart';

import '../../../core/constanat/colors.dart';

class CustomDropDownStarRating extends StatelessWidget {
  final List<DropDownStarsModel> items;
  final void Function(String? val) onchanged;
  final String value;
  final String nameofitem;
  final bool ireq;
  const CustomDropDownStarRating({
    super.key,
    required this.items,
    required this.onchanged,
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
            style: AppTextStyles.h14b,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.beige,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          width: 170.sp,
          child: DropdownButton(
            items:
                items.map((e) {
                  return DropdownMenuItem(
                    value: e.value,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children:e.stars),
                  );
                }).toList(),
            onChanged: onchanged,
            focusColor: Colors.black,
            iconEnabledColor: Colors.white,
            value: value,
            style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
            isExpanded: true,
            dropdownColor: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
