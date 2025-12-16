import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trip/core/constanat/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:trip/data/temp_todelete/0.dbcontroller.dart';

import '../../controller/drawer_controller.dart';

class CustomDrower extends StatelessWidget {
  CustomDrower({super.key});
  final pref = Get.find<SharedPreferencesService>();
  @override
  Widget build(BuildContext context) {
    MyDrawerController controller = Get.put(MyDrawerController());
    return Drawer(
      child: Container(
        color: AppColors.white,
        child: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(height: Get.width / 3, color: AppColors.beige),
                Positioned(
                  top: Get.width / 3.9,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.beige,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[100],
                      backgroundImage: AssetImage("Assets/images/unnamed.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                color: AppColors.beige,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      // onTap: () {},
                      trailing: Obx(
                        () => Switch(
                          onChanged: (val) {
                            Get.find<DbController>().toggleUserID();
                          },
                          value:
                              Get.find<DbController>().userId.value == 1
                                  ? true
                                  : false,
                          activeThumbColor: AppColors.blue,
                        ),
                      ),
                      title: Text(
                        "enable_notifications".tr(),
                        style: AppTextStyles.h15b,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        if (Get.locale == Locale('en')) {
                          await context.setLocale(Locale('ar'));
                          Get.updateLocale(Locale('ar'));
                          pref.setLanguage('ar');
                          AppTextStyles.init();
                        } else {
                          await context.setLocale(Locale('en'));
                          Get.updateLocale(Locale('en'));
                          pref.setLanguage('en');
                          AppTextStyles.init();
                        }
                      },
                      trailing: Icon(
                        Icons.language_outlined,
                        color: AppColors.brown,
                      ),
                      title: Text("language".tr(), style: AppTextStyles.h15b),
                    ),
                    ListTile(
                      onTap: () {
                        controller.goToPersonalInfo();
                      },
                      trailing: const Icon(
                        Icons.settings,
                        color: AppColors.brown,
                      ),
                      title: Text(
                        "personal_info".tr(),
                        style: AppTextStyles.h15b,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        controller.goToAboutUs();
                      },
                      trailing: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.brown,
                      ),
                      title: Text(
                        "who_we_are_drawer".tr(),
                        style: AppTextStyles.h15b,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.help_outline_rounded),
                      title: Text(
                        "our_company".tr(),
                        style: AppTextStyles.h15b,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.phone_callback_outlined,
                        color: AppColors.brown,
                      ),
                      title: Text("contact_us".tr(), style: AppTextStyles.h15b),
                    ),
                    ListTile(
                      onTap: () {
                        controller.logout();
                      },
                      title: Text("sign_out".tr(), style: AppTextStyles.h15b),
                      trailing: const Icon(
                        Icons.exit_to_app,
                        color: AppColors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
