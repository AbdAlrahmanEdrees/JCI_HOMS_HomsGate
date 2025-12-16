import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/hotel.dart';
import 'package:trip/view/screen/advertisement_panel/hotels/2.hotel_profile.dart';
import 'package:trip/view/widget/Advertisement/ad_widgets.dart';
import 'package:trip/view/widget/Advertisement/custom_badge.dart';
import 'package:trip/view/widget/Advertisement/image_place_holder.dart';
import 'package:trip/view/widget/Advertisement/stat_pill.dart';

class HotelAdCard extends StatelessWidget {
  final Hotel hotel;
  const HotelAdCard({super.key, required this.hotel});

  // String _firstPhotoPath(List<String> list) {
  //   if (list.isEmpty) return '';
  //   return list.first.trim();
  // }

  // List<String> _csv(String csv) =>
  //     csv.trim().isEmpty ? [] : csv.split(',').map((e) => e.trim()).toList();

  @override
  Widget build(BuildContext context) {
    final widgetsAndTools = AdWidgetsAndTools();
    final photos = widgetsAndTools.splitCsv(hotel.photos);
    final mainPath = widgetsAndTools.firstPhotoPath(photos);
    final exists = mainPath.isNotEmpty ? File(mainPath).existsSync() : false;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.to(HotelProfile(hotel: hotel)),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.beige, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---- Image with badges
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                        exists
                            ? Hero(
                              tag: 'hotel_${hotel.adID ?? hotel.hotelName}',
                              child: Image.file(
                                File(mainPath),
                                fit: BoxFit.cover,
                              ),
                            )
                            : ImagePlaceholder(),
                  ),
                  // Positioned(
                  //   top: 10.h,
                  //   left: 10.w,
                  //   child: CustomBadge(
                  //     label:'${'rent'.tr()} • ${hotel.}',
                  //     color: AppColors.beige.withValues(alpha:0.9),
                  //     icon: Icons.key_rounded,
                  //   ),
                  // ),
                  if ((hotel.usPricePerNight) > 0)
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: CustomBadge(
                        label:
                            '${'avg_price_per_night'.tr()}: ${hotel.usPricePerNight}',
                        color: AppColors.brown.withValues(alpha: 0.9),
                        icon: Icons.attach_money_rounded,
                        darkText: true,
                      ),
                    ),
                ],
              ),

              // ---- Title & quick meta
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.hotelName,
                      style: AppTextStyles.h13b,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        if (hotel.hasParking == 1)
                          StatPill(
                            icon: Icons.garage,
                            label: 'yes_has_parking'.tr(),
                          ),
                        if (hotel.hasPool == 1)
                          StatPill(icon: Icons.pool, label: 'has_pool'.tr()),
                      ],
                    ),

                    // optional separator
                    SizedBox(height: 10.h),
                    const Divider(height: 1, color: Color(0x1F000000)),
                    SizedBox(height: 10.h),

                    // ---- CTA row (copy ad id / address preview)
                    Row(
                      children: [
                        if (hotel.adID != null)
                          TextButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: '${hotel.adID}'),
                              );
                              Get.snackbar(
                                'copied'.tr(),
                                'ad_copied'.tr(),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.beige,
                                colorText: AppColors.brown,
                              );
                            },
                            icon: const Icon(Icons.copy, size: 18),
                            label: Text(
                              'ad_id'.tr(),
                              style: AppTextStyles.h16b,
                            ),
                          ),
                        const Spacer(),
                        if (hotel.address.trim().isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: AppColors.brown,
                              ),
                              SizedBox(width: 4.w),
                              SizedBox(
                                width: 160.w,
                                child: Text(
                                  hotel.address,
                                  style: AppTextStyles.h16b,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
