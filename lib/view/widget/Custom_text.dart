import 'package:flutter/material.dart';
import 'package:trip/core/constanat/textstyles.dart';

class CustomText extends StatelessWidget {
  final String? data;
  final Color? color;
  final double? fontsize;
  final AlignmentGeometry? align;

  const CustomText({
    super.key,
    this.data,
    this.color = Colors.black,
    this.fontsize = 12,
    this.align = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: align,
      child: Text(
        data!,
        style: AppTextStyles.h16b
      ),
    );
  }
}
