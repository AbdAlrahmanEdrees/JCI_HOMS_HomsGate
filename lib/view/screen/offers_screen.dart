import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:trip/controller/userProprty/user_property_controller.dart';
import 'package:trip/view/widget/custom_card_handling.dart';
import 'package:trip/view/widget/property_card.dart';
import '../../../core/class/handlingrequstveiw.dart';
import '../../../data/models/propertymodel.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserPropertyController controller = Get.put(UserPropertyController());
    return Scaffold(
      backgroundColor: const Color(0xF3F3F3E7),
      body: GetBuilder<UserPropertyController>(
        builder: (controller) {
          return HandlingDataViewShimmer(
            shimmerwidget: const CustomCardHandling(),
            statusRequest: controller.statusRequest,
            widget:
                controller.data.isEmpty
                    ? Center(child: Text("no_added_properties_to_show".tr()))
                    : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        PropertyModel data = controller.data[index];
                        return InkWell(
                          onTap: () {
                            controller.goToDetailsProperty(data);
                          },
                          child: CustomPropertyCard(
                            cover: data.coverPhoto!,
                            title: data.title ?? "",
                            street: data.location?.street ?? "",
                            location: data.location?.city ?? "",
                            price: " ${data.price}",
                            isfav: false,
                            onFavPressed: () {},
                            onDeletePressed: () {
                              controller.deleteProperty(data.slug!, index);
                            },
                            onUpdatePressed: () {
                              controller.goToUpdateScreen(data);
                            },
                            isuserproperty: true,
                            istrad: '',
                            ownertybe: '',
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
