import 'package:flutter/material.dart';
import 'package:trip/controller/filters/search_by_price_widget_controller.dart';
import 'package:get/get.dart';

import '../../../core/constanat/colors.dart';

class CustomRangeSlider extends StatelessWidget {
  // final RangeValues selectedRange;
  final ValueChanged<RangeValues> onChanged;
  final bool isEnabled; // Add this parameter
  const CustomRangeSlider({
    super.key,
    // required this.selectedRange,
    required this.onChanged,
    required this.isEnabled, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchByPriceWidgetController>(
      init: SearchByPriceWidgetController(),
      builder:(controller)=> RangeSlider(
        activeColor:
            isEnabled
                ? AppColors.blue
                : AppColors.beige, // Change color based on enabled/disabled state
        inactiveColor:
            isEnabled ? Colors.grey[300] : Colors.grey, // Change inactive color
        min: controller.start,
        max: controller.sliderMaxValue,
        values: controller.selectedRange!,
        onChanged: isEnabled ? onChanged : null, // Enable/Disable slider
      ),
    );
  }
}
