import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/personal_info_controller.dart';

import '../../core/constanat/colors.dart';
import '../widget/personal_info/custom_listtile.dart';
import '../widget/personal_info/custom_text_field.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalInfoController controller = Get.find();
    print(controller.data!.city);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greencolor,
        title: Text(
          "personal_info".tr(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PersonalInfoController>(
        builder: (controller) {
          return Form(
            key: controller.key,
            child:
                controller.data == null
                    ? const Center(child: Text("الرجاء الانتظار قليلا"))
                    : SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomListTile(
                            title: "user_name".tr(),
                            subtitle: controller.data!.fullName!,
                            onTap: () {
                              controller.name.text = controller.data!.fullName!;
                              controller.defultDialog(
                                controller.data!.fullName!,
                                "edit_user_name".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.name,
                                  isnum: false,
                                  initval: controller.data!.fullName!,
                                ),
                                controller.name,
                                'fullName',
                              );
                            },
                            iconData: Icons.person,
                          ),
                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "password".tr(),
                            subtitle: "*****************",
                            onTap: () {
                              controller.pass.text = "**************";

                              controller.defultDialog(
                                "",
                                "edit_password".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.pass,
                                  isnum: false,
                                  initval: "***************",
                                ),
                                controller.pass,
                                'user.password',
                              );
                            },
                            iconData: Icons.password,
                          ),
                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "personal_email".tr(),
                            subtitle: controller.data!.email!,
                            onTap: () {
                              controller.email.text = controller.data!.email!;
                              controller.defultDialog(
                                controller.data!.email!,
                                "edit_email".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.email,
                                  isnum: false,
                                  initval: controller.data!.email!,
                                ),
                                controller.email,
                                'email',
                              );
                            },
                            iconData: Icons.email,
                          ),

                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "city".tr(),
                            subtitle: controller.data!.city!,
                            onTap: () {
                              controller.city.text = controller.data!.city!;
                              controller.defultDialog(
                                controller.data!.city!,
                                "city".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.city,
                                  isnum: false,
                                  initval: controller.data!.city!,
                                ),
                                controller.city,
                                'city',
                              );
                            },
                            iconData: Icons.location_history,
                          ),
                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "gender".tr(),
                            subtitle: "male".tr(),
                            onTap: () {},
                            iconData: Icons.gamepad_outlined,
                          ),
                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "phone_number".tr(),
                            subtitle: controller.data!.phoneNumber!,
                            onTap: () {
                              controller.phone.text =
                                  controller.data!.phoneNumber!;

                              controller.defultDialog(
                                controller.data!.phoneNumber!,
                                "edit_phone_number".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.phone,
                                  isnum: false,
                                  initval: controller.data!.phoneNumber!,
                                ),
                                controller.phone,
                                'phone_number',
                              );
                            },
                            iconData: Icons.phone,
                          ),
                          SizedBox(height: 5.h),
                          CustomListTile(
                            title: "about_the_user".tr(),
                            subtitle: controller.data!.aboutMe!,
                            onTap: () {
                              controller.about.text = controller.data!.aboutMe!;
                              controller.defultDialog(
                                controller.data!.aboutMe!,
                                "edit_user_description".tr(),
                                CustomTextFieldPersonal(
                                  controller: controller.about,
                                  isnum: false,
                                  initval: controller.data!.aboutMe!,
                                ),
                                controller.about,
                                'about_me',
                              );
                            },
                            iconData: Icons.info,
                          ),
                        ],
                      ),
                    ),
          );
        },
      ),
    );
  }
}
