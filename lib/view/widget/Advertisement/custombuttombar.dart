import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constanat/colors.dart';

class CustomButtomBar extends StatelessWidget {
  final void Function()? onPressednext;
  final void Function()? onPressedremove;

  const CustomButtomBar({
    super.key,
    required this.onPressednext,
    required this.onPressedremove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greencolor,
      width: double.infinity,
      height: 50.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: onPressedremove,
            child: const Text("إلغاء", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: onPressednext,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text("تأكيد", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
