import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/mainpagecontroller.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:trip/data/static/categorydata.dart';
import 'package:trip/view/widget/mainpage/customcategory.dart';

class EstatesPanel extends StatelessWidget {
  const EstatesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Container(
      // color: AppColors.grey300.withOpacity(0.3),
      color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //title: "عرض الكل",
                  Text(
                    "buy_or_rent_estates_in_syria".tr(),
                    style: AppTextStyles.h13b ,
                    
                  ),
                  // CustomButton(title: "browse_all".tr(), onpress: () {}),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: 190.sp,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CategoryData().data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.sp,
                    crossAxisSpacing: 7.sp,
                    mainAxisSpacing: 30.sp,
                  ),
                  itemBuilder: (context, index) {
                    var data = CategoryData().data[index];
                    return InkWell(
                      onTap: () {
                        controller.gotodetailsscreen(
                          data.type,
                          controller.category,
                          index,
                        );
                      },
                      child: CustomCategory(
                        imageurl: data.imageurl,
                        title: data.title.tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
