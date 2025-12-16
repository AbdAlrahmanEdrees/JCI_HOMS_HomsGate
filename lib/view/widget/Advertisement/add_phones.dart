import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';

class AddPhonesWidget extends StatelessWidget {
  final TextEditingController phoneTextEditingController;
  final List<String> phoneNumbersAdded;
  final GetxController getxController;
  const AddPhonesWidget({
    super.key,
    required this.phoneTextEditingController,
    required this.phoneNumbersAdded,
    required this.getxController,
  });
  // final controller = Get.find<CarAdController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          child: SizedBox(
            height: 30.sp,
            child: Row(
              spacing: 15.sp,
              children: [
                SizedBox(
                  width: 5.sp,
                  child: Icon(Icons.star, color: Colors.yellow, size: 15),
                ),
                Expanded(
                  child: SizedBox(
                    // height: 30.sp,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.beige,
                        // borderRadius: BorderRadius.circular(15.sp),
                        border: BoxBorder.all(color: AppColors.brown, width: 1),
                      ),
                      width: 170.sp,
                      child: TextField(
                        style: AppTextStyles.h15b,
                        decoration: InputDecoration(
                          hintText: 'phone_number'.tr(),
                          hintStyle: AppTextStyles.p1,
                          // border: const OutlineInputBorder(),
                        ),
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  color: AppColors.beige,
                  onPressed: () {
                    phoneNumbersAdded.add(phoneTextEditingController.text);
                    phoneTextEditingController.text = '';
                    getxController.update();
                  },
                  child: Text(
                    "add".tr(),
                    style: AppTextStyles.h15b
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 3.sp),
        Container(
          width: screenWidth * 0.85,
          // color: AppColors.white,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.brown,),
          ),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: phoneNumbersAdded.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder:
                  (context, index) => SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(phoneNumbersAdded[index],style: AppTextStyles.p1,),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: AppColors.brown,),
                        onPressed: () {
                          phoneNumbersAdded.removeAt(index);
                          getxController.update();
                        },
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
