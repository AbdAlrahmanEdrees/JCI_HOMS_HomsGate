import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/class/handlingrequstveiw.dart';

import '../../../controller/userProprty/update_user_property_contoller.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/Advertisement/addpropertytext.dart';
import '../../widget/Advertisement/custombuttomaditionalfuture.dart';
import '../../widget/Advertisement/custombuttombar.dart';
import '../../widget/Advertisement/custompanner.dart';
import '../../widget/Advertisement/customphotocard.dart';
import '../../widget/Advertisement/customradiobuttom.dart';
import '../../widget/Advertisement/custom_drop_down_menu.dart';

class UpdateUserProprty extends StatelessWidget {
  const UpdateUserProprty({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateUserPropertyController controller = Get.put(
      UpdateUserPropertyController(),
    );
    return Scaffold(
      appBar: AppBar(title: Text("edit_property".tr())),
      body: GetBuilder<UpdateUserPropertyController>(
        builder: (controller) {
          return CustomDotedHandlingData(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.propertydetailsKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomBanner(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRedioButton(
                          val: "for_rent".tr(),
                          groupval: controller.stutus,
                          onchanged: (val) {
                            controller.changestutus(val);
                          },
                          title: 'for_rent'.tr(),
                        ),
                        CustomRedioButton(
                          val: "for_sale".tr(),
                          groupval: controller.stutus,
                          onchanged: (val) {
                            controller.changestutus(val);
                          },
                          title: "for_sale".tr(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pickImages();
                                },
                                child:
                                    controller.imgFile != null
                                        ? Container(
                                          padding: EdgeInsets.all(5),
                                          width: 100.w,
                                          height: 100.h,
                                          child: Image.file(
                                            controller.imgFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                        : SizedBox(
                                          width: 100.w,
                                          height: 100.h,
                                          child: CustomPhotoCardUpdate(
                                            imageurl:
                                                controller.data.coverPhoto!,
                                          ),
                                        ),
                              ),
                              Text(
                                "put_main_photo_for_your_property".tr(),
                                style: TextStyle(
                                  fontFamily: "Tejwal",
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          CustomDropDownMenu(
                            items: controller.items.typeOfEstate,
                            onchanged: (String? val) {
                              controller.updateType(
                                val!,
                                controller.typeOfPropertyselected,
                              );
                            },
                            value: controller.typeOfPropertyselected,
                            nameofitem: "property_type".tr(),
                            ireq: true,
                          ),
                          SizedBox(height: 14.sp),

                          AddPropertyText(
                            dataText: controller.data.title!,
                            nameofitem: "property_name".tr(),
                            isreq: true,
                            controller: controller.title,
                            isnum: false,
                            valid: (String? val) {
                              return validInput(val!, 3, 10, "type");
                            },
                          ),
                          SizedBox(height: 10.sp),
                          controller.changeitems
                              ? AddPropertyText(
                                dataText: "${controller.data.price}",
                                nameofitem: "price".tr(),
                                isreq: true,
                                controller: controller.price,
                                isnum: true,
                                valid: (String? val) {
                                  return validInput(val!, 3, 15, "type");
                                },
                              )
                              : AddPropertyText(
                                dataText: "",
                                isnum: true,
                                nameofitem: "the_rent".tr(),
                                isreq: true,
                                controller: controller.price,
                                valid: (String? val) {
                                  return validInput(val!, 3, 15, "type");
                                },
                              ),
                          AddPropertyText(
                            dataText: controller.data.plotArea,
                            isnum: true,
                            nameofitem: "space".tr(),
                            isreq: true,
                            controller: controller.size,
                            valid: (String? val) {
                              return validInput(val!, 3, 6, "type");
                            },
                          ),
                          CustomDropDownMenu(
                            items: controller.items.floor,
                            onchanged: (String? val) {
                              controller.updateType(
                                val!,
                                controller.floorselected,
                              );
                            },
                            value: controller.floorselected,
                            nameofitem: "floor_number".tr(),
                            ireq: true,
                          ),
                          SizedBox(height: 10.sp),
                          // DropDownProperty(
                          //   items: controller.items.prpertyFounder,
                          //   onchanged: (String? val) {
                          //     controller.updateTybe(val!,controller.prpertyFounderselected);
                          //   },
                          //   value: controller.prpertyFounderselected,
                          //   nameofitem: 'نوع الملكية',
                          //   ireq: true,
                          // ),
                          SizedBox(height: 10.sp),
                          AddPropertyText(
                            dataText: "${controller.data.totalRooms}",
                            isnum: true,
                            nameofitem: "no_of_rooms".tr(),
                            isreq: true,
                            controller: controller.numOfRoom,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: "${controller.data.bedrooms}",
                            isnum: true,
                            nameofitem: "no_of_bedrooms".tr(),
                            isreq: true,
                            controller: controller.bedroom,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: "${controller.data.livingRooms}",

                            isnum: true,
                            nameofitem: "no_of_living_rooms".tr(),
                            isreq: true,
                            controller: controller.livingroom,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: "${controller.data.kitchens}",

                            isnum: true,
                            nameofitem: "no_of_kitchens".tr(),
                            isreq: true,
                            controller: controller.kitchin,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: "",

                            isnum: true,
                            nameofitem: "no_of_bathrooms".tr(),
                            isreq: true,
                            controller: controller.bathroom,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: "${controller.data.floorNumber}",
                            isnum: true,
                            nameofitem: "property_number".tr(),
                            isreq: true,
                            controller: controller.numofproperty,
                            valid: (String? val) {
                              return validInput(val!, 1, 2, "type");
                            },
                          ),
                          controller.changeitems
                              ? CustomDropDownMenu(
                                items: controller.items.ownertype,
                                onchanged: (String? val) {
                                  controller.updateType(
                                    val!,
                                    controller.Ownertypeselected,
                                  );
                                },
                                value: controller.Ownertypeselected,
                                nameofitem: "seller_type".tr(),
                                ireq: true,
                              )
                              : CustomDropDownMenu(
                                items: controller.items.rentalPeriod,
                                onchanged: (String? val) {
                                  controller.updateType(
                                    val!,
                                    controller.conditionselected,
                                  );
                                },
                                value: controller.Rentalperiodselected,
                                nameofitem: "rental_type".tr(),
                                ireq: true,
                              ),
                          SizedBox(height: 10.sp),
                          CustomDropDownMenu(
                            items: controller.items.clothingLevel,
                            onchanged: (String? val) {
                              controller.updateType(
                                val!,
                                controller.claddingselected,
                              );
                            },
                            value: controller.claddingselected,
                            nameofitem: "cladding".tr(),
                            ireq: true,
                          ),
                          SizedBox(height: 10.sp),
                          CustomDropDownMenu(
                            items: controller.items.direction,
                            onchanged: (String? val) {
                              controller.updateType(
                                val!,
                                controller.directionselected,
                              );
                            },
                            value: controller.directionselected,
                            nameofitem: "direction".tr(),
                            ireq: true,
                          ),
                          SizedBox(height: 10.sp),
                          // DropDownProperty(
                          //   items: controller.items.condition,
                          //   onchanged: (String? val) {
                          //     controller.updateTybe(val!,controller.conditionselected);
                          //   },
                          //   value: controller.conditionselected,
                          //   nameofitem: 'الإكساء',
                          //   ireq: false,
                          // ),
                          SizedBox(height: 10.sp),
                          CustomDropDownMenu(
                            items: controller.items.governorate,
                            onchanged: (String? val) {
                              controller.updateType(
                                val!,
                                controller.locationselected,
                              );
                            },
                            value: controller.locationselected,
                            nameofitem: "location".tr(),
                            ireq: true,
                          ),
                          SizedBox(height: 10.sp),
                          AddPropertyText(
                            dataText: controller.data.location!.street!,

                            isnum: false,
                            nameofitem: "street".tr(),
                            isreq: true,
                            controller: controller.street,
                            valid: (String? val) {
                              return validInput(val!, 1, 20, "type");
                            },
                          ),
                          AddPropertyText(
                            dataText: controller.data.location!.region!,

                            isnum: false,
                            nameofitem: "region".tr(),
                            isreq: true,
                            controller: controller.regoin,
                            valid: (String? val) {
                              return validInput(val!, 3, 20, "type");
                            },
                          ),

                          SizedBox(height: 20.sp),
                          Container(
                            padding: EdgeInsets.all(5.sp),
                            width: double.infinity,
                            child: Text(
                              "additional_features".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Tejwal",
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButtomAditional(
                                    varname: controller.pool,
                                    onTap: () {
                                      controller
                                          .changestateofAdditionalfeatures(
                                            "pool",
                                          );
                                    },
                                    label: 'pool'.tr(),
                                  ),

                                  CustomButtomAditional(
                                    varname: controller.solar_panels,
                                    onTap: () {
                                      controller
                                          .changestateofAdditionalfeatures(
                                            "solar_panels",
                                          );
                                    },
                                    label: "solar_panels".tr(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.sp),
                              CustomButtomAditional(
                                varname: controller.elevator,
                                onTap: () {
                                  controller.changestateofAdditionalfeatures(
                                    "elevator",
                                  );
                                },
                                label: "elevator".tr(),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.sp),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 125.sp,
                                  child: Text(
                                    "description".tr(),
                                    style: TextStyle(
                                      fontFamily: "Tejwal",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 50),
                                  width: 5.sp,
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            validator: (String? val) {
                              return validInput(val!, 1, 1000, "type");
                            },
                            controller: controller.description,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "put_your_description_here".tr(),
                            ),
                          ),
                          SizedBox(height: 20.sp),
                          CustomButtomBar(
                            onPressednext: () {
                              controller.UpdateData();
                            },
                            onPressedremove: () {
                              controller.onCancle();
                            },
                          ),
                        ],
                      ),
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
