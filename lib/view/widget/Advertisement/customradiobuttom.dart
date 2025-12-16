import 'package:flutter/material.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';

class CustomRedioButton extends StatelessWidget {
  final String val;
  final String title;
  final String groupval;
  final void Function(String?) onchanged;

  const CustomRedioButton({
    super.key,
    required this.val,
    required this.groupval,
    required this.onchanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: val,
          groupValue: groupval,
          onChanged: onchanged,
          activeColor: AppColors.blue,
        ),
        Text(title, style: AppTextStyles.h14b,),
      ],
    );
  }
}
