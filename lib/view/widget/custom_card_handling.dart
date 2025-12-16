import 'package:flutter/material.dart';
import 'package:trip/view/widget/property_card.dart';

class CustomCardHandling extends StatelessWidget {
  const CustomCardHandling({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 4,
      itemBuilder: (context, index) {
        return CustomPropertyCard(
          isuserproperty: false,
          cover: "",
          title: "",
          street: "",
          location: "",
          price: "",
          isfav: false,
          onFavPressed: () {},
          onDeletePressed: () {},
          onUpdatePressed: () {},
          istrad: '',
          ownertybe: '',
        );
      },
    );
  }
}
