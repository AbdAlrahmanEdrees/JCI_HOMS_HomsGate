import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'package:url_launcher/url_launcher.dart'; 

class AdWidgetsAndTools{
  
  //===================================================
  //====================  Functions  ====================
  List<String> splitCsv(String csv) => //csv: comma separated values.
      csv.trim().isEmpty ? [] : csv.split(',').map((e) => e.trim()).toList();

  Future<void> callNumber(String number) async { // Uri: Uniform Resource Identifier
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
  String firstPhotoPath(List<String> list) {
    if (list.isEmpty) return '';
    return list.first.trim();
  }
  //==================================
  /// Open a website in browser:
  /// Uri.parse('https://flutter.dev');
  /// ================================
  /// Google Maps/ Apple Maps:
  /// Uri.parse('geo:37.7749,-122.4194')
  /// ================================
  /// Whatsapp message: Uri.parse('https://wa.me/123456789?text=Hello%20from%20my%20app');
  /// 
  /// 
  //===================================================
  //====================  Card  ====================



  //===================================================
  //====================  Profile  ====================
  
Widget dividerLight() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.beige.withValues(alpha:0.8),
      ),
    );
  }
}