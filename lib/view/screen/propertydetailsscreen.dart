import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:jiffy/jiffy.dart';
import 'package:trip/core/class/handlingrequstveiw.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/view/widget/propertydetails/customdatadetails.dart';
import 'package:trip/view/widget/propertydetails/customlabel.dart';
import 'package:trip/view/widget/propertydetails/imageviewer.dart';
import '../../controller/details_controllers/propertydetailscontroller.dart';
import '../widget/propertydetails/custom_handling_data_property.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PropertyDetailsController controller = Get.put(PropertyDetailsController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 45.sp,
        child: GestureDetector(
          onTap: () {
            if (controller.data?.phoneNumber != null) {
              controller.callwithphone(controller.data!.phoneNumber!);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone, color: AppColors.greencolor),
              SizedBox(width: 10.sp),
              Text("contact_with_the_owner".tr()),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "property_details".tr(),
          style: TextStyle(
            fontFamily: "TejwalBold",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PropertyDetailsController>(
        builder: (controller) {
          return HandlingDataViewShimmer(
            shimmerwidget: CustomhandlingDataPropertyDetails(),
            statusRequest: controller.statusRequest,
            widget:
                controller.data == null
                    ? CustomhandlingDataPropertyDetails()
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            controller.data == null
                                ? Center(child: Text("no_data_to_show".tr()))
                                : ImageViewer(imageUrls: controller.imageurl),
                            SizedBox(height: 10.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios_new, size: 10),
                                      Text("compare".tr()),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: AppColors.greencolor,
                                  width: 50.sp,
                                  height: 20.sp,
                                  child: Text(
                                    controller.data!.propertyStatus!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomLabel(label: "${controller.data!.price}"),
                                const SizedBox(height: 15),
                                CustomLabel(label: "property_description".tr()),
                                Text(
                                  "${controller.data!.description}",
                                  style: const TextStyle(fontFamily: "Tejwal"),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(height: 10.sp),
                                CustomLabel(label: "property_features".tr()),
                                const Divider(color: Colors.grey),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDataDetails(
                                      imageurl: "Assets/images/88.png",
                                      title: "space".tr(),
                                      ammount: "${controller.data!.plotArea}",
                                    ),
                                    controller.data!.propertyStatus == 'للأجار'
                                        ? Divider(color: Colors.grey.shade100)
                                        : Container(),
                                    controller.data!.propertyStatus == 'للأجار'
                                        ? CustomDataDetails(
                                          imageurl: "Assets/images/88.png",
                                          title: "rental_type".tr(),
                                          ammount:
                                              "${controller.data!.rentType}",
                                        )
                                        : Container(),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/8.png",
                                      title: "floor_number".tr(),
                                      ammount:
                                          "${controller.data!.floorNumber}",
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/8888888.png",
                                      title: "ownership_type".tr(),
                                      ammount:
                                          "${controller.data!.ownershipType}",
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/125126-200.png",
                                      title: "no_of_rooms".tr(),
                                      ammount:
                                          "${controller.data!.totalFloors}",
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/125126-200.png",
                                      title: "no_of_kitchens".tr(),
                                      ammount: "${controller.data!.kitchens}",
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/125126-200.png",
                                      title: "no_of_living_rooms".tr(),
                                      ammount:
                                          "${controller.data!.livingRooms}",
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/125126-200.png",
                                      title: "no_of_bedrooms".tr(),
                                      ammount: "${controller.data!.bedrooms}",
                                    ),

                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/888.png",
                                      title: "seller_type".tr(),
                                      ammount: controller.data!.userType!,
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/8888.png",
                                      title: "furniture".tr(),
                                      ammount: controller.data!.furnishing!,
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/88888.png",
                                      title: "direction".tr(),
                                      ammount: "qibla".tr(),
                                    ),
                                    Divider(color: Colors.grey.shade100),
                                    CustomDataDetails(
                                      imageurl: "Assets/images/8888888.png",
                                      title: "status".tr(),
                                      ammount: "v_good".tr(),
                                    ),

                                    Divider(color: Colors.grey.shade100),
                                  ],
                                ),
                                CustomLabel(label: "location".tr()),
                                CustomDataDetails(
                                  imageurl: "Assets/images/8888888.png",
                                  title: "city".tr(),
                                  ammount: controller.data!.location!.city!,
                                ),
                                Divider(color: Colors.grey.shade100),

                                CustomDataDetails(
                                  imageurl: "Assets/images/8888888.png",
                                  title: "region".tr(),
                                  ammount: controller.data!.location!.region!,
                                ),
                                Divider(color: Colors.grey.shade100),

                                CustomDataDetails(
                                  imageurl: "Assets/images/8888888.png",
                                  title: "street".tr(),
                                  ammount: controller.data!.location!.street!,
                                ),

                                Divider(color: Colors.grey.shade100),
                                CustomLabel(label: "additional_features".tr()),
                                SizedBox(height: 10.sp),
                                controller.data!.elevator!
                                    ? CustomDataDetails(
                                      imageurl: "Assets/images/8888888.png",
                                      title: "elevator".tr(),
                                      ammount: "1",
                                    )
                                    : Container(),

                                controller.data!.pool!
                                    ? CustomDataDetails(
                                      imageurl: "Assets/images/8888888.png",
                                      title: "pool".tr(),
                                      ammount: "1",
                                    )
                                    : Container(),
                                SizedBox(height: 10.sp),
                                CustomLabel(label: "ad_details".tr()),
                                SizedBox(height: 10.sp),
                                CustomDataDetails(
                                  imageurl: "Assets/images/8888888.png",
                                  title: "posting_date".tr(),
                                  ammount: Jiffy.parse(
                                    controller.data!.createdAt!,
                                  ).format(pattern: 'MMMM do yyyy, '),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
          );
        },
      ),
    );
  }
}
