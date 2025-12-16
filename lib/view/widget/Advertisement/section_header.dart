
import 'package:flutter/material.dart';
import 'package:trip/core/constanat/textstyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.h13b);
  }
}