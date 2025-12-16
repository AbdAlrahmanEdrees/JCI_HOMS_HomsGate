import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip/controller/advertisements/adImagesController.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';
import 'package:trip/view/widget/mainpage/custonbuttom.dart';

/// =============================
/// Stateless Widget
/// =============================
/// Usage:
/// Get.put(AdImagesController());
/// controller.setImages(pickedXFiles);
///
/// Then place AdsImagesGrid() in your UI.
class AdsImagesGrid extends StatelessWidget {
  const AdsImagesGrid({
    super.key,
    this.crossAxisCount = 3,
    this.spacing = 8,
    this.tileRadius = 10,
  });

  final int crossAxisCount;
  final double spacing;
  final double tileRadius;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<AdImagesController>();
    final controller = Get.put(AdImagesController());
    final adController = Get.find<AdvertisementController>();
    return Obx(() {
      final imgs = adController.images;
      final mainIdx = adController.mainIndex.value;
      final validation = controller.validationMessage;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            onpress: () {
              controller.pickImages(true);
            },
            title: "pick_images".tr(),
          ),
          if (validation != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                validation,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: imgs.length,
            padding: EdgeInsets.all(spacing),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemBuilder: (context, index) {
              return _DraggableTile(
                file: imgs[index],
                index: index,
                isMain: index == mainIdx,
                onTap: () {
                  controller.setMain(
                    index,
                  ); // HINT: reflect main image in your ad state if needed
                },
                onAcceptFrom: (from) {
                  controller.reorder(
                    from,
                    index,
                  ); // HINT: persist new order if needed
                },
                radius: tileRadius,
              );
            },
          ),
        ],
      );
    });
  }
}

/// =============================
/// Private draggable/tile piece
/// =============================
class _DraggableTile extends StatelessWidget {
  const _DraggableTile({
    required this.file,
    required this.index,
    required this.isMain,
    required this.onTap,
    required this.onAcceptFrom,
    required this.radius,
  });

  final XFile file;
  final int index;
  final bool isMain;
  final VoidCallback onTap;
  final void Function(int from) onAcceptFrom;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final baseTile = GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.file(File(file.path), fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.6, 1.0],
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                border: Border.all(
                  color: isMain ? Colors.blueAccent : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          if (isMain)
            Positioned(
              left: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'MAIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index,
      onAcceptWithDetails: (details) => onAcceptFrom(details.data),
      builder: (context, candidates, rejected) {
        final highlight = candidates.isNotEmpty;

        final decorated = AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius + 2),
            boxShadow:
                highlight
                    ? [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ]
                    : const [],
          ),
          child: baseTile,
        );

        return LongPressDraggable<int>(
          data: index,
          feedback: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(radius + 2),
            child: SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius + 2),
                child: Image.file(File(file.path), fit: BoxFit.cover),
              ),
            ),
          ),
          childWhenDragging: Opacity(opacity: 0.2, child: decorated),
          onDragStarted: () {
            // Optional: HapticFeedback.selectionClick();
          },
          child: decorated,
        );
      },
    );
  }
}
