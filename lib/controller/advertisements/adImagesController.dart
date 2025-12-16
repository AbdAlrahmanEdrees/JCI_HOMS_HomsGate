// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip/controller/advertisements/advertisementController.dart';

class AdImagesController extends GetxController {
  final adController = Get.find<AdvertisementController>();
  Future<void> pickImages(bool multiImage) async {
    // List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
    //   imageQuality: 50,
    // );
    // selectedImages = pickedImages.map((file) => File(file.path)).toList();
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );
    adController.images.assignAll(pickedImages);
    print(adController.images);
    update();
  }

  removephoto(int index) {
    adController.images.removeAt(index);
    update();
  }

  /// Set a specific image as main
  void setMain(int index) {
    if (index < 0 || index >= adController.images.length) return;
    adController.mainIndex.value = index;
    // HINT: persist main index to your ad form state
  }

  /// Reorder images (drag from -> to)
  void reorder(int from, int to) {
    if (from == to ||
        from < 0 ||
        to < 0 ||
        from >= adController.images.length ||
        to >= adController.images.length) {
      return;
    }

    final moved = adController.images.removeAt(from);
    adController.images.insert(to, moved);

    // Keep mainIndex consistent after reordering
    if (adController.mainIndex.value == from) {
      adController.mainIndex.value = to;
    } else if (from < to) {
      if (adController.mainIndex.value > from &&
          adController.mainIndex.value <= to) {
        adController.mainIndex.value--;
      }
    } else {
      if (adController.mainIndex.value >= to &&
          adController.mainIndex.value < from) {
        adController.mainIndex.value++;
      }
    }

    // HINT: persist new order to your ad form state
  }

  /// Validation helper
  String? get validationMessage {
    if (adController.images.length < 3) return 'Please add at least 3 images.';
    if (adController.images.length > 12) {
      return 'You can add up to 12 images only.';
    }
    return null;
  }

  /// Convenience getter for consumers that need the current ordered list
  List<XFile> get orderedImages => List<XFile>.of(adController.images);
}
