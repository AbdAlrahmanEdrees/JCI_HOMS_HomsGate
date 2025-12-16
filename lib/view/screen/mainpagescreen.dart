import 'package:flutter/material.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/view/widget/mainpage/estates_panel.dart';
import 'package:get/get.dart' hide Trans;
// both get and easy_localization have a function called tr()
import 'package:trip/view/screen/advertisement_panel/advertisements_panel.dart';
import 'package:trip/view/widget/mainpage/lands_panel.dart';
import '../../controller/mainpagecontroller.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({super.key});
  final controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beige,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          children: [
            const AdvertisementsPanel(),
            EstatesPanel(),
            LandsPanel(),
            SizedBox(
              height: 10,
            ), // It's to add some space, becasue the ImageSlider was sticking too closely to the bottom navigation bar
          ],
        ),
      ),
    );
  }
}
