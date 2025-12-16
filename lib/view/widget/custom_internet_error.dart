import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trip/core/constanat/image.dart';
class CoustomInternetError extends StatelessWidget {
  const CoustomInternetError({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          const Text("أنت غير متصل .... الرجاء الاتصال بالانترنت "),
          SizedBox(height: 10.sp,),
          Lottie.asset(AppImage.offlineimage)
        ],
      ),
    );
  }
}
