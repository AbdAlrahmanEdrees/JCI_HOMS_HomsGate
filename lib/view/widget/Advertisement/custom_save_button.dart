// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trip/core/constanat/colors.dart';
// import 'package:trip/core/constanat/textstyles.dart';

// class CustomSaveButton extends StatelessWidget {
//   final IconData icon;
//   final bool saved;
//   const CustomSaveButton({super.key, 
//     required this.icon,
//     this.saved = false,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(color: AppColors.white.withValues(alpha:0.7), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26.withValues(alpha:0.08),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 16.sp,
//             color: darkText ? AppColors.white : AppColors.brown,
//           ),
//           SizedBox(width: 6.w),
//           Text(label, style: textStyle),
//         ],
//       ),
//     );
//   }
// }