import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/textstyles.dart';

import '../../../core/constanat/colors.dart';

class CustomTextFieldDigital extends StatelessWidget {
  final TextEditingController textEditingController;
  final String nameofitem;
  final bool ireq;
  const CustomTextFieldDigital({
    super.key,
    required this.textEditingController,
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
            border: BoxBorder.all(color: AppColors.brown,width: 1)
          ),
          width: 170.sp,
          child: TextField(
            controller: textEditingController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: AppTextStyles.h15b,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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