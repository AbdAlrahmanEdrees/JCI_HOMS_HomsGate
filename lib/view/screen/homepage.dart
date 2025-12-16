import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/view/widget/custom_drower.dart';
import '../../controller/homepagecontroller.dart';
import '../../core/constanat/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp homePageControllerImp = Get.put(
      HomePageControllerImp(),
    );
    return GetBuilder<HomePageControllerImp>(
      init: HomePageControllerImp(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.beige,
      drawer: CustomDrower(),
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.brown),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          controller.pageTitles[controller.page].tr(),
          style: AppTextStyles.h11b,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       controller.goToFavScreen();
        //     },
        //     icon: const Icon(Icons.favorite_border),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       controller.goToCustomizeScreen();
        //     },
        //     icon: const Icon(Icons.notification_add_outlined),
        //   ),
        // ],
      ),
          bottomNavigationBar: CurvedNavigationBar(
            key: homePageControllerImp.bottomNavigationKey,
            index: controller.page,
            items: [
              CurvedNavigationBarItem(
                child: Icon(Icons.home_outlined,color: AppColors.brown,),
                label: "home".tr(),
                labelStyle: AppTextStyles.p1.copyWith(fontSize: 14)
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.bookmark_outline,color: AppColors.brown,),
                label: "saved".tr(),
                labelStyle: AppTextStyles.p1.copyWith(fontSize: 14)
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.holiday_village,color: AppColors.brown,),
                label: "my_ads".tr(),
                labelStyle: AppTextStyles.p1.copyWith(fontSize: 14)
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.newspaper,color: AppColors.brown,),
                label: "offers".tr(),
                labelStyle: AppTextStyles.p1.copyWith(fontSize: 14)
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.control_point,color: AppColors.brown,),
                label: "add_property".tr(),
                labelStyle: AppTextStyles.p1.copyWith(fontSize: 14)
                
              ),
            ],
            color: AppColors.white,
            buttonBackgroundColor: AppColors.white,
            backgroundColor: AppColors.brown,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              homePageControllerImp.onpress(index);
            },
            letIndexChange: (index) => true,
          ),
          body: homePageControllerImp.pages[homePageControllerImp.page],
        );
      },
    );
  }
}
