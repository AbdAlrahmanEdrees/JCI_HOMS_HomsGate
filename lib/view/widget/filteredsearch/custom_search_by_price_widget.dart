// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:easy_localization/easy_localization.dart';
// import 'package:trip/controller/filters/search_by_price_widget_controller.dart';
// import 'package:trip/core/constanat/colors.dart';
// import 'package:trip/core/constanat/textstyles.dart';
// import 'package:trip/view/widget/Custom_text.dart';
// import 'package:trip/view/widget/filteredsearch/CustomRangeSlider.dart';

// class CustomSearchByPrice extends StatelessWidget {
//   double usdRangeStart, usdRangeEnd, sliderMaxValue;
//   CustomSearchByPrice({
//     super.key,
//     this.usdRangeStart = 10,
//     this.usdRangeEnd = 100,
//     this.sliderMaxValue=1000
//   });
//   final SearchByPriceWidgetController controller = Get.put(
//     SearchByPriceWidgetController(),
//   );
//   @override
//   Widget build(BuildContext context) {
//     controller.setRange(usdRangeStart, usdRangeEnd, sliderMaxValue);
//     return GetBuilder<SearchByPriceWidgetController>(
//       builder: (controller) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Checkbox(
//                   value: controller.isSliderEnabled,
//                   onChanged: (bool? value) {
//                     controller.toggleSlider(value!);
//                   },
//                 ),
//                 Text(
//                   "activate_search_by_price".tr(),
//                   style: TextStyle(fontFamily: "Tejwal", fontSize: 16.sp),
//                 ),
//                 SizedBox(width: 9),
//                 DropdownButton(
//                   value: controller.currencyValue,
//                   style: AppTextStyles.h3.copyWith(
//                     color: Colors.black,
//                     fontSize: 12.sp,
//                   ),
//                   items: [
//                     DropdownMenuItem(value: 0, child: Text("usd".tr())),
//                     DropdownMenuItem(
//                       value: 1,
//                       child: Text("syrian_pound".tr()),
//                     ),
//                   ],
//                   onChanged: (v) {
//                     if (v != null) {
//                       controller.changeCurrency((v));
//                     }
//                   },
//                 ),
//               ],
//             ),
//             controller.changeItems
//                 ? Text(
//                   "acceptable_price_range".tr(),
//                   style: TextStyle(
//                     color: AppColors.greencolor,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Tejwal",
//                     fontSize: 15.sp,
//                   ),
//                 )
//                 : Text(
//                   "acceptable_rent_range".tr(),
//                   style: TextStyle(
//                     color: AppColors.greencolor,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Tejwal",
//                     fontSize: 15.sp,
//                   ),
//                 ),
//             controller.changeItems
//                 ? Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomText(
//                         data:
//                             " ${controller.selectedRange!.start.toInt()} ${controller.numberSuffix.tr()} ${controller.currency.tr()}",
//                         fontsize: 15,
//                       ),
//                       CustomText(
//                         data:
//                             " ${controller.selectedRange!.end.toInt()} ${controller.numberSuffix.tr()} ${controller.currency.tr()}",
//                         fontsize: 15,
//                       ),
//                     ],
//                   ),
//                 )
//                 : Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomText(
//                         data:
//                             " ${controller.selectedRange!.start.toInt()} ${'syrian_pound'.tr()}",
//                         fontsize: 15,
//                       ),
//                       CustomText(
//                         data:
//                             " ${"syrian_pound".tr()} ${controller.selectedRange!.end.toInt()}",
//                         fontsize: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//             CustomRangeSlider(
//               selectedRange: controller.selectedRange!,
//               onChanged: (RangeValues newValues) {
//                 controller.changeRange(newValues);
//               },
//               isEnabled: controller.isSliderEnabled, // Pass the enabled state
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
