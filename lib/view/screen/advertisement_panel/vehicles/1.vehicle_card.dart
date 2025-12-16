import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/controller/advertisements/car_ad_controller.dart';

import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/models/ads_objects/vehicle.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';
import 'package:trip/view/screen/advertisement_panel/vehicles/2.vehicle_profile.dart';
import 'package:trip/view/widget/Advertisement/ad_widgets.dart';
import 'package:trip/view/widget/Advertisement/custom_badge.dart';
import 'package:trip/view/widget/Advertisement/image_place_holder.dart';
import 'package:trip/view/widget/Advertisement/stat_pill.dart';

class VehicleAdCard extends StatelessWidget {
  final Vehicle car;
  final bool saved;
  const VehicleAdCard({super.key, required this.car, required this.saved});

  // String _firstPhotoPath(List<String> list) {
  //   if (list.isEmpty) return '';
  //   return list.first.trim();
  // }

  // List<String> _csv(String csv) =>
  //     csv.trim().isEmpty ? [] : csv.split(',').map((e) => e.trim()).toList();

  @override
  Widget build(BuildContext context) {
    final widgetsAndTools = AdWidgetsAndTools();
    final photos = widgetsAndTools.splitCsv(car.photos);
    final mainPath = widgetsAndTools.firstPhotoPath(photos);
    final exists = mainPath.isNotEmpty ? File(mainPath).existsSync() : false;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.to(VehicleProfile(vehicle: car)),
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
                              tag:
                                  'car_${car.adID ?? '${car.brand}_${car.model}'}',
                              child: Image.file(
                                File(mainPath),
                                fit: BoxFit.cover,
                              ),
                            )
                            : ImagePlaceholder(),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: CustomBadge(
                      label:
                          car.forSale == 1
                              ? 'for_sale'.tr()
                              : '${'for_rent'.tr()} • ${car.typeOfRent}',
                      color:
                          car.forSale == 1
                              ? AppColors.blue
                              : AppColors.beige.withOpacity(0.9),
                      icon:
                          car.forSale == 1
                              ? Icons.sell_rounded
                              : Icons.key_rounded,
                    ),
                  ),
                  if ((car.usPrice) > 0)
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: CustomBadge(
                        label: '${'us_price'.tr()}: ${car.usPrice}',
                        color: AppColors.brown.withOpacity(0.9),
                        icon: Icons.attach_money_rounded,
                        darkText: true,
                      ),
                    ),
                  Positioned(
                    top: 40.h,
                    right: 10.w,
                    child: IconButton(
                      onPressed: () {
                        final db = Get.find<DbController>();
                        saved
                            ? db.removeBookAd(car.adID!)
                            : db.bookAd(car.adID!);
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          Get.find<CarAdController>().update();
                        });
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: saved ? AppColors.blue : AppColors.brown,
                      ),
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
                      '${car.brand.capitalize} ${car.model.capitalize}',
                      style: AppTextStyles.h13b,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        StatPill(
                          icon: Icons.calendar_today_rounded,
                          label: '${'year'.tr()}: ${car.year}',
                        ),
                        StatPill(
                          icon: Icons.settings_rounded,
                          label:
                              '${'transmission'.tr()}: ${car.transmission.capitalize}',
                        ),
                        if (car.kilometersTraveled > 0)
                          StatPill(
                            icon: Icons.speed_rounded,
                            label:
                                '${'kilometers'.tr()}: ${car.kilometersTraveled}',
                          ),
                        if (car.governorate.trim().isNotEmpty)
                          StatPill(
                            icon: Icons.place_rounded,
                            label: car.governorate.capitalize!,
                          ),
                      ],
                    ),

                    // optional separator
                    SizedBox(height: 10.h),
                    const Divider(height: 1, color: Color(0x1F000000)),
                    SizedBox(height: 10.h),

                    // ---- CTA row (copy ad id / address preview)
                    Row(
                      children: [
                        if (car.adID != null)
                          TextButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: '${car.adID}'),
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
                        if (car.address.trim().isNotEmpty)
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
                                  car.address,
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
