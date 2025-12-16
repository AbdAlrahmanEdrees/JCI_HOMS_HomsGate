import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/core/constanat/colors.dart';

class ImageSliderFiles extends StatefulWidget {
  final List<String> imagePaths;
  final double? height;
  final bool showDots;
  final bool enableZoomDialog;

  const ImageSliderFiles({
    super.key,
    required this.imagePaths,
    this.height,
    this.showDots = false,
    this.enableZoomDialog = false,
  });

  @override
  State<ImageSliderFiles> createState() => _ImageSliderFilesState();
}

class _ImageSliderFilesState extends State<ImageSliderFiles> {
  int _current = 0;

  void _openZoomDialog(int initialIndex) {
    if (!widget.enableZoomDialog) return;
    if (widget.imagePaths.isEmpty) return;

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        final controller = PageController(initialPage: initialIndex);
        int localIndex = initialIndex;

        return StatefulBuilder(
          builder: (context, setSt) => GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: widget.imagePaths.length,
                  onPageChanged: (i) => setSt(() => localIndex = i),
                  itemBuilder: (_, i) {
                    final path = widget.imagePaths[i];
                    final exists = File(path).existsSync();
                    return Center(
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 4,
                        child: exists
                            ? Image.file(File(path), fit: BoxFit.contain)
                            : _placeholder(),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 28.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: widget.imagePaths.isEmpty
                          ? 1
                          : widget.imagePaths.length,
                      position: localIndex.toDouble(),
                      decorator: DotsDecorator(
                        size: Size(7.r, 7.r),
                        activeSize: Size(9.r, 9.r),
                        color: Colors.white38,
                        activeColor: AppColors.blue,
                        spacing: EdgeInsets.all(4.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.beige.withOpacity(0.4),
      child: Icon(Icons.photo, color: AppColors.brown, size: 36.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? 180.h;

    if (widget.imagePaths.isEmpty) {
      return SizedBox(
        height: height,
        child: _placeholder(),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imagePaths.length-1,
          itemBuilder: (context, index, realIdx) {
            final path = widget.imagePaths[index];
            final exists = File(path).existsSync();

            return GestureDetector(
              onTap: () => _openZoomDialog(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.beige.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.beige, width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: exists
                    ? Image.file(
                        File(path),
                        width: double.infinity,
                        height: height,
                        fit: BoxFit.cover,
                      )
                    : _placeholder(),
              ),
            );
          },
          options: CarouselOptions(
            height: height,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            enlargeFactor: 0.14,
            autoPlay: widget.imagePaths.length > 1,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            enableInfiniteScroll: widget.imagePaths.length > 1,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),
        if (widget.showDots)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: DotsIndicator(
              dotsCount: widget.imagePaths.length-1,
              position: _current.toDouble(),
              decorator: DotsDecorator(
                size: Size(6.r, 6.r),
                activeSize: Size(8.r, 8.r),
                color: AppColors.beige.withOpacity(0.8),
                activeColor: AppColors.blue,
                spacing: EdgeInsets.all(3.r),
              ),
            ),
          ),
      ],
    );
  }
}
