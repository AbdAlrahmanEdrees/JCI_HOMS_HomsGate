import 'package:flutter/material.dart';

import 'Custom_text.dart';

class CoustomElevatedButtomSocial extends StatelessWidget {
  final String? text;
  final String? imageurl;
  final Function()? onpress;
  const CoustomElevatedButtomSocial({
    super.key,
    this.text,
    this.imageurl,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.grey.shade100,
      ),
      onPressed: onpress,
      child: Row(
        children: [
          Image.asset(imageurl!, width: 30, height: 30),
          SizedBox(width: 80),
          CustomText(data: text),
        ],
      ),
    );
  }
}
