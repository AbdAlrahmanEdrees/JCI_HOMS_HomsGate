import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/estate.dart';
import 'package:trip/view/widget/Advertisement/ad_widgets.dart';
import 'package:trip/view/widget/Advertisement/chip_tag.dart';
import 'package:trip/view/widget/Advertisement/info_row.dart';
import 'package:trip/view/widget/Advertisement/section_header.dart';
import 'package:trip/view/widget/imagesliderfiles.dart';

class EstateProfile extends StatelessWidget {
  final Estate estate;
  const EstateProfile({super.key, required this.estate});

  @override
  Widget build(BuildContext context) {
    final AdWidgetsAndTools adTools = AdWidgetsAndTools();
    final photos = adTools.splitCsv(estate.photos);
    final phones = adTools.splitCsv(estate.phoneNumbers);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text('estate_details'.tr(), style: AppTextStyles.h12b),
        iconTheme: const IconThemeData(color: AppColors.brown),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---- Gallery ----
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    color: AppColors.beige.withOpacity(0.35),
                    child: ImageSliderFiles(
                      imagePaths: photos, // << changed param name
                      height: 240.h,
                      showDots: true,
                      enableZoomDialog: true,
                    ),
                  ),
                ),
              ),

              // ---- Title / Quick tags ----
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('estate_overview'.tr(), style: AppTextStyles.h11b),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ChipTag(
                          icon: Icons.place_rounded,
                          label:
                              '${'governorate'.tr()}: ${estate.governorate.tr().capitalize}',
                        ),
                        ChipTag(
                          icon: Icons.square_foot_rounded,
                          label: '${'space'.tr()}: ${estate.space}',
                        ),
                        if (estate.address.trim().isNotEmpty)
                          ChipTag(
                            icon: Icons.location_on_outlined,
                            label: estate.address,
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // ---- Details card ----
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 1.2, color: AppColors.beige),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(title: 'details'.tr()),
                      SizedBox(height: 12.h),
                      InfoRow(
                        icon: Icons.house,
                        label: 'type_of_estate'.tr(),
                        value: estate.type.tr().capitalize!,
                      ),
                      ...[
                      adTools.dividerLight(),
                      InfoRow(
                        icon: Icons.stairs_outlined,
                        label: 'floor_number'.tr(),
                        value: '${estate.floorNumber}',
                      ),
                    ],
                      if (estate.numOfRooms != null ||
                          estate.numOfFloors != 0) ...[
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.bed,
                          label: 'number_of_rooms'.tr(),
                          value: '${estate.numOfRooms}',
                        ),
                      ],
                      if (estate.clothing != '') ...[
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.format_paint,
                          label: 'cladding'.tr(),
                          value: estate.clothing.tr(),
                        ),
                      ],
                      // if (estate.hasWifi!=null && estate.hasWifi==1) ...[
                      //   _DividerLight(),
                      //   _InfoRow(
                      //     icon: Icons.wifi,
                      //     label: 'has_wifi'.tr(),
                      //     value: '',
                      //   ),
                      // ],
                      // _InfoRow(
                      //   icon: Icons.square_foot_rounded,
                      //   label: 'space'.tr(),
                      //   value: '${estate.space}',
                      // ),
                      // if (estate.usPrice!=0) ...
                      // [
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.attach_money,
                          label: 'price'.tr(),
                          value: '${estate.usPrice}',
                        ),
                      // ],
                      if (estate.description.trim().isNotEmpty) ...[
                        SizedBox(height: 12.h),
                        SectionHeader(title: 'description'.tr()),
                        SizedBox(height: 8.h),
                        Text(estate.description, style: AppTextStyles.p2),
                      ],
                    ],
                  ),
                ),
              ),

              // ---- Contact card ----
              if (phones.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(width: 1.2, color: AppColors.beige),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(title: 'contact'.tr()),
                        SizedBox(height: 8.h),
                        ...List.generate(phones.length, (i) {
                          final number = phones[i];
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: AppColors.blue.withOpacity(
                                    0.2,
                                  ),
                                  child: const Icon(
                                    Icons.phone,
                                    color: AppColors.brown,
                                  ),
                                ),
                                title: Text(
                                  '${'phone'.tr()} ${i + 1}'.tr(args: []),
                                  style: AppTextStyles.h15b,
                                ),
                                subtitle: Text(number, style: AppTextStyles.p2),
                                trailing: Wrap(
                                  spacing: 6.w,
                                  children: [
                                    IconButton(
                                      onPressed:
                                          () => adTools.callNumber(number),
                                      icon: const Icon(Icons.call),
                                      tooltip: 'call'.tr(),
                                      color: AppColors.brown,
                                    ),
                                    IconButton(
                                      onPressed:
                                          () => Clipboard.setData(
                                            ClipboardData(text: number),
                                          ).then(
                                            (_) => Get.snackbar(
                                              'copied'.tr(),
                                              'phone_copied'.tr(),
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: AppColors.beige,
                                              colorText: AppColors.brown,
                                            ),
                                          ),
                                      icon: const Icon(Icons.copy),
                                      tooltip: 'copy'.tr(),
                                      color: AppColors.brown,
                                    ),
                                  ],
                                ),
                              ),
                              if (i != phones.length - 1) adTools.dividerLight(),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Small UI helpers ----------

// class _SectionHeader extends StatelessWidget {
//   final String title;
//   const _SectionHeader({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(title, style: AppTextStyles.h13b);
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const _InfoRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: AppColors.brown, size: 20.sp),
//         SizedBox(width: 10.w),
//         Expanded(
//           child: RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(text: '$label: ', style: AppTextStyles.p1b),
//                 TextSpan(text: value, style: AppTextStyles.p2),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DividerLight extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Divider(
//         height: 1,
//         thickness: 1,
//         color: AppColors.beige.withOpacity(0.8),
//       ),
//     );
//   }
// }

// class _ChipTag extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _ChipTag({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//       labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
//       backgroundColor: AppColors.beige.withOpacity(0.5),
//       shape: StadiumBorder(side: BorderSide(color: AppColors.beige, width: 1)),
//       avatar: Icon(icon, size: 18.sp, color: AppColors.brown),
//       label: Text(label, style: AppTextStyles.h16b),
//     );
//   }
// }
