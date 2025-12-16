import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/services/shared_preferences/pref_service.dart';
import 'package:get/get.dart';

class AppTextStyles {
  static bool _isArabic = false;

  /// Call this once during app startup (e.g. in main or splash)
  static Future<void> init() async {
    final prefs = Get.find<SharedPreferencesService>();
    _isArabic = prefs.getLanguage() == 'ar';
  }

  // ----------------------
  // Helpers
  // ----------------------
  static String get _headerFontCairo =>
      _isArabic ? 'Cairo' : 'Sans_Serif_Poppins';
  static String get _headerFontGE =>
      _isArabic ? 'GE_SS_Unique' : 'Sans_Serif_Poppins';
  static String get _paragraphFont =>
      _isArabic ? 'Noto_Sans_Arabic' : 'Sans_Serif_Poppins';

  // ----------------------
  // Cairo Headers (h1x)
  // ----------------------
  static TextStyle h11b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Bold
    fontSize: 22.sp,
    color: AppColors.brown,
  );

  static TextStyle h12b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Regular
    fontSize: 20.sp,
    color: AppColors.brown,
  );

  static TextStyle h13b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Light
    fontSize: 18.sp,
    color: AppColors.brown,
  );
  static TextStyle h14b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Light
    fontSize: 16.sp,
    color: AppColors.brown,
  );
  static TextStyle h15b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Light
    fontSize: 14.sp,
    color: AppColors.brown,
  );
  static TextStyle h16b = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w700, // Cairo Bold / Poppins Light
    fontSize: 12.sp,
    color: AppColors.brown,
  );
  static TextStyle h13r = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w400, // Cairo Regular / Poppins Light
    fontSize: 20.sp,
    color: Colors.black87,
  );
  static TextStyle h13l = TextStyle(
    fontFamily: _headerFontCairo,
    fontWeight: FontWeight.w300, // Cairo Light / Poppins Light
    fontSize: 20.sp,
    color: Colors.black87,
  );

  // ----------------------
  // GE_SS_Unique Headers (h2x)
  // ----------------------
  static TextStyle h21 = TextStyle(
    fontFamily: _headerFontGE,
    fontWeight: FontWeight.w700, // GE Bold / Poppins Bold
    fontSize: 24.sp,
    color: Colors.black,
  );

  static TextStyle h22 = TextStyle(
    fontFamily: _headerFontGE,
    fontWeight: FontWeight.w300, // GE Light / Poppins Light
    fontSize: 22.sp,
    color: Colors.black,
  );

  // ----------------------
  // Paragraphs (p1, p2...)
  // ----------------------
  static TextStyle p1b = TextStyle(
    fontFamily: _paragraphFont,
    fontWeight: FontWeight.w700, // Noto Regular / Poppins Regular
    fontSize: 16.sp,
    color: AppColors.brown,
  );
  static TextStyle p1 = TextStyle(
    fontFamily: _paragraphFont,
    fontWeight: FontWeight.w400, // Noto Regular / Poppins Regular
    fontSize: 16.sp,
    color: AppColors.brown,
  );

  static TextStyle p2 = TextStyle(
    fontFamily: _paragraphFont,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.brown,
  );
}









// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTextStyles {
//   // static TextStyle h1 = GoogleFonts.notoSans(
//   //   color: Colors.black87,
//   //   fontWeight: FontWeight.w500,
//   //   fontSize: 25,
//   // );
//   // static TextStyle h2 = GoogleFonts.notoSans(
//   //   color: Colors.white,
//   //   fontWeight: FontWeight.w500,
//   //   fontSize: 20.sp,
//   // );
//   // static TextStyle h3 = GoogleFonts.notoSans(
//   //   color: Colors.white,
//   //   fontWeight: FontWeight.w500,
//   //   fontSize: 16,
//   // );
//   // static TextStyle h4 = GoogleFonts.notoSans(
//   //   color: Colors.black87,
//   //   fontWeight: FontWeight.w400,
//   //   fontSize: 18,
//   // );
//   // static TextStyle font3 = GoogleFonts.cairo(
//   //   color: Colors.black87,
//   //   fontWeight: FontWeight.w500,
//   //   fontSize: 26,
//   // );
// }
