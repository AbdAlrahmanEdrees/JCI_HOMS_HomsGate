// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchDialogWidget extends StatelessWidget {
//   final GetxController getxControllerClass;
//   const SearchDialogWidget({super.key,required this.getxControllerClass});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: context.width),
//         child: GetBuilder<HotelBookingController>(
//           builder: (controller) {
//             final rentalItems = controller.items.rentalPeriod.take(2).toList();

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // --- Dropdowns ---
//                   CustomDropDownMenu(
//                     items: controller.items.governorate,
//                     onchanged:
//                         (val) => controller.updateTypeOfDropDown(
//                           "locationselected",
//                           val ?? '',
//                         ),
//                     value: controller.locationselected,
//                     nameofitem: 'location'.tr(),
//                     ireq: false,
//                   ),
//                   const SizedBox(height: 8),
//                   CustomDropDownMenu(
//                     items: rentalItems,
//                     onchanged:
//                         (val) => controller.updateTypeOfDropDown(
//                           'Rentalperiodselected',
//                           val ?? '',
//                         ),
//                     value: controller.rentalPeriodSelected,
//                     nameofitem: 'rental_type'.tr(),
//                     ireq: false,
//                   ),
//                   const SizedBox(height: 12),

//                   // --- Divider ---
//                   Container(
//                     width: double.infinity, // let dialog constraints win
//                     height: 1,
//                     color: AppColors.grey300,
//                   ),
//                   const SizedBox(height: 12),

//                   // --- Toggle ---
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Checkbox(
//                         value: controller.isSliderEnabled,
//                         onChanged: (v) => controller.toggleSlider(v ?? false),
//                       ),
//                       Text(
//                         "activate_search_by_price".tr(),
//                         style: const TextStyle(
//                           fontFamily: "Tejwal",
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // --- Range label ---
//                   Text(
//                     controller.changeitems
//                         ? "acceptable_price_range".tr()
//                         : "acceptable_rent_range".tr(),
//                     style: TextStyle(
//                       color: AppColors.greencolor,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Tejwal",
//                       fontSize: 15,
//                     ),
//                   ),

//                   // --- Values row ---
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomText(
//                           data:
//                               " ${controller.selectedRange.start.toInt()} ${controller.changeitems ? 'million'.tr() : 'syrian_pound'.tr()}",
//                           fontsize: 15,
//                         ),
//                         CustomText(
//                           data:
//                               " ${controller.selectedRange.end.toInt()} ${controller.changeitems ? 'million'.tr() : 'syrian_pound'.tr()}",
//                           fontsize: 15,
//                         ),
//                       ],
//                     ),
//                   ),

//                   // --- Slider ---
//                   // CustomRangeSlider(
//                   //   selectedRange: controller.selectedRange,
//                   //   onChanged: controller.isSliderEnabled
//                   //       ? (rv) => controller.changeRange(rv)
//                   //       : null,
//                   //   isEnabled: controller.isSliderEnabled,
//                   // ),
//                   CustomRangeSlider(
//                     selectedRange: controller.selectedRange,
//                     onChanged: (RangeValues newValues) {
//                       controller.changeRange(newValues);
//                     },
//                     isEnabled:
//                         controller.isSliderEnabled, // Pass the enabled state
//                   ),
//                   const SizedBox(height: 12),

//                   // --- Action ---
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed:
//                           controller.statusRequest == StatusRequest.loading
//                               ? null
//                               : controller.uplodeData,
//                       child:
//                           controller.statusRequest == StatusRequest.loading
//                               ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                               : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "search".tr(),
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   const Icon(Icons.search, color: Colors.white),
//                                 ],
//                               ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
