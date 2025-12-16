import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/restaurantorcafe.dart';
import 'package:trip/view/widget/Advertisement/ad_widgets.dart';
import 'package:trip/view/widget/Advertisement/chip_tag.dart';
import 'package:trip/view/widget/Advertisement/info_row.dart';
import 'package:trip/view/widget/Advertisement/section_header.dart';
import 'package:trip/view/widget/imagesliderfiles.dart';

class RestaurantAndCafeProfile extends StatelessWidget {
  final RestaurantOrCafe ad;
  const RestaurantAndCafeProfile({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final AdWidgetsAndTools adTools = AdWidgetsAndTools();
    final photos = adTools.splitCsv(ad.photos);
    final phones = adTools.splitCsv(ad.phoneNumbers);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text('ad_details'.tr(), style: AppTextStyles.h12b),
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
                    Text('overview'.tr(), style: AppTextStyles.h11b),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ChipTag(
                          icon: Icons.place_rounded,
                          label:
                              '${'governorate'.tr()}: ${ad.governorate.tr().capitalize}',
                        ),
                        if (ad.address.trim().isNotEmpty)
                          ChipTag(
                            icon: Icons.location_on_outlined,
                            label: ad.address,
                          ),
                        if (ad.hasDelivery == 0)
                          ChipTag(
                            icon: Icons.delivery_dining,
                            label: 'has_delivery'.tr(),
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
                        label: 'type'.tr(),
                        value: ad.type.tr().capitalize!,
                      ),
                      ...[
                      adTools.dividerLight(),
                      InfoRow(
                        icon: Icons.access_time,
                        label: 'open_at'.tr(),
                        value: '${ad.openHour} ${ad.amOrPmOpen.tr()}',
                      ),
                    ],
                      ...[
                      adTools.dividerLight(),
                      InfoRow(
                        icon: Icons.nightlight,
                        label: 'close_at'.tr(),
                        value: '${ad.closeHour} ${ad.amOrPmClose.tr()}',
                      ),
                    ],
                      if (ad.hasWifi >=0) ...[
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.wifi,
                          label: '',
                          value: 'has_internet'.tr(),
                        ),
                      ],
                      if (ad.hasElectricity >=0) ...[
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.power,
                          label: '',
                          value: 'has_electricity'.tr(),
                        ),
                      ],
                        adTools.dividerLight(),
                        InfoRow(
                          icon: Icons.attach_money,
                          label: 'avg_us_bill'.tr(),
                          value: '${ad.usPrice}',
                        ),
                      // ],
                      if (ad.menuAndDescription.trim().isNotEmpty) ...[
                        SizedBox(height: 12.h),
                        SectionHeader(title: 'menu_and_description'.tr()),
                        SizedBox(height: 8.h),
                        Text(ad.menuAndDescription, style: AppTextStyles.p2),
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
