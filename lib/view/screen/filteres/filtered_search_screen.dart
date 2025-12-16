// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:easy_localization/easy_localization.dart';
// import 'package:trip/controller/filters/filtered_search_controller.dart';
// import 'package:trip/core/class/stutusconntection.dart';
// import 'package:trip/core/constanat/colors.dart';

// import '../../widget/Custom_text.dart';
// import '../../widget/addAdvertisement/customradiobuttom.dart';
// import '../../widget/addAdvertisement/custom_drop_down_menu.dart';
// import '../../widget/filteredsearch/CustomRangeSlider.dart';

// class FilteredSearch extends StatelessWidget {
//   const FilteredSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     FilteredSearchController controller = Get.put(FilteredSearchController());
//     return Scaffold(
//       body: GetBuilder<FilteredSearchController>(
//         builder: (controller) {
//           return Container(
//             // decoration: const BoxDecoration(
//             //   image: DecorationImage(
//             //     image: AssetImage("Assets/images/12.jpg"),
//             //     fit: BoxFit.fitHeight,
//             //   ),
//             // ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomRedioButton(
//                         val: "for_rent".tr(),
//                         groupval: controller.stutus,
//                         onchanged: (val) {
//                           controller.changestutus(val!);
//                         },
//                         title: 'rent'.tr(),
//                       ),
//                       CustomRedioButton(
//                         val: "for_sale".tr(),
//                         groupval: controller.stutus,
//                         onchanged: (val) {
//                           controller.changestutus(val!);
//                         },
//                         title: 'sale'.tr(),
//                       ),
//                     ],
//                   ),
//                   CustomDropDownMenu(
//                     items: controller.items.typeOfEstate,
//                     onchanged: (String? val) {
//                       controller.updateTypeOfDropDown(
//                         'tybeOfPropertyselected',
//                         val!,
//                       );
//                     },
//                     value: controller.typeOfPropertyselected,
//                     nameofitem: "property_type".tr(),
//                     ireq: true,
//                   ),
//                   SizedBox(height: 14.sp),
//                   CustomDropDownMenu(
//                     items: controller.items.floor,
//                     onchanged: (String? val) {
//                       controller.updateTypeOfDropDown('floorselected', val!);
//                     },
//                     value: controller.floorselected,
//                     nameofitem: "floor_number".tr(),
//                     ireq: true,
//                   ),
//                   SizedBox(height: 10.sp),
//                   CustomDropDownMenu(
//                     items: controller.items.clothingLevel,
//                     onchanged: (String? val) {
//                       controller.updateTypeOfDropDown('claddingselected', val!);
//                     },
//                     value: controller.claddingselected,
//                     nameofitem: 'furniture'.tr(),
//                     ireq: true,
//                   ),
//                   SizedBox(height: 10.sp),
//                   CustomDropDownMenu(
//                     items: controller.items.condition,
//                     onchanged: (String? val) {
//                       controller.updateTypeOfDropDown(
//                         'conditionselected',
//                         val!,
//                       );
//                     },
//                     value: controller.conditionselected,
//                     nameofitem: 'cladding'.tr(),
//                     ireq: false,
//                   ),
//                   SizedBox(height: 10.sp),
//                   controller.changeitems
//                       ? Container()
//                       : CustomDropDownMenu(
//                         items: controller.items.rentalPeriod,
//                         onchanged: (String? val) {
//                           controller.updateTypeOfDropDown(
//                             'Rentalperiodselected',
//                             val!,
//                           );
//                         },
//                         value: controller.Rentalperiodselected,
//                         nameofitem: "rental_type".tr(),
//                         ireq: false,
//                       ),
//                   SizedBox(height: 10.sp),
//                   CustomDropDownMenu(
//                     items: controller.items.governorate,
//                     onchanged: (String? val) {
//                       controller.updateTypeOfDropDown('locationselected', val!);
//                     },
//                     value: controller.locationselected,
//                     nameofitem: 'location'.tr(),
//                     ireq: true,
//                   ),
//                   SizedBox(height: 10.sp),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Checkbox(
//                         value: controller.isSliderEnabled,
//                         onChanged: (bool? value) {
//                           controller.toggleSlider(value!);
//                         },
//                       ),
//                       Text(
//                         "activate_search_by_price".tr(),
//                         style: TextStyle(fontFamily: "Tejwal", fontSize: 20.sp),
//                       ),
//                     ],
//                   ),
//                   controller.changeitems
//                       ? Text(
//                         "acceptable_price_range".tr(),
//                         style: TextStyle(
//                           color: AppColors.greencolor,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Tejwal",
//                           fontSize: 15.sp,
//                         ),
//                       )
//                       : Text(
//                         "acceptable_rent_range".tr(),
//                         style: TextStyle(
//                           color: AppColors.greencolor,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Tejwal",
//                           fontSize: 15.sp,
//                         ),
//                       ),
//                   controller.changeitems
//                       ? Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomText(
//                               data:
//                                   " ${controller.selectedRange.start.toInt()} ${'million'.tr()} ",
//                               fontsize: 15,
//                             ),
//                             CustomText(
//                               data:
//                                   " ${controller.selectedRange.end.toInt()} ${'million'.tr()}",
//                               fontsize: 15,
//                             ),
//                           ],
//                         ),
//                       )
//                       : Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomText(
//                               data:
//                                   " ${controller.selectedRange.start.toInt()} ${'syrian_pound'.tr()}",
//                               fontsize: 15,
//                             ),
//                             CustomText(
//                               data:
//                                   " ${"syrian_pound".tr()} ${controller.selectedRange.end.toInt()}",
//                               fontsize: 15,
//                             ),
//                           ],
//                         ),
//                       ),
//                   CustomRangeSlider(
//                     selectedRange: controller.selectedRange,
//                     onChanged: (RangeValues newValues) {
//                       controller.changeRange(newValues);
//                     },
//                     isEnabled:
//                         controller.isSliderEnabled, // Pass the enabled state
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         controller.uplodeData();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             controller.statusRequest == StatusRequest.loading
//                                 ? Colors.grey
//                                 : AppColors.greencolor,
//                       ),
//                       child:
//                           controller.statusRequest == StatusRequest.loading
//                               ? CircularProgressIndicator(color: Colors.white)
//                               : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "search".tr(),
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   Icon(Icons.search, color: Colors.white),
//                                 ],
//                               ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
