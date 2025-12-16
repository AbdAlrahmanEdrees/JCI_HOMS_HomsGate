//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/textstyles.dart';

import '../../../core/constanat/colors.dart';

class CustomTextFieldHoursWithUnitsTrailer extends StatelessWidget {
  final TextEditingController textEditingController;
  final String nameofitem;
  final String unit;
  final Function()? tapOnUnit;
  final bool ireq;
  const CustomTextFieldHoursWithUnitsTrailer({
    super.key,
    required this.textEditingController,
    required this.nameofitem,
    required this.unit,
    this.tapOnUnit,
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
            color: AppColors.beige,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          width: 170.sp,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.sp,
                child: TextField(
                  style: AppTextStyles.h15b,
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Expanded(child: SizedBox()),
              // Expanded(child: SizedBox(),),
              InkWell(
                onTap: tapOnUnit,
                child: Text(
                  unit.tr(),
                  style: AppTextStyles.h16b,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// DropdownButton(
//             items:
//                 items.map((e) {
//                   return DropdownMenuItem(
//                     value: e.value,
//                     child: Text(e.text, textAlign: TextAlign.center),
//                   );
//                 }).toList(),
//             onChanged: onchanged,
//             focusColor: Colors.black,
//             iconEnabledColor: Colors.white,
//             value: value,
//             style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
//             isExpanded: true,
//             dropdownColor: Color(0xff008f7b),
//           ),