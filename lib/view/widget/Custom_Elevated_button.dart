import 'package:flutter/material.dart';

import 'Custom_text.dart';

class CoustomElevatedButtom extends StatelessWidget {
  final String? text;
  final Function()? onpress;
  const CoustomElevatedButtom({super.key, this.text, this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onpress,
      child: CustomText(
        data: text,
        fontsize: 16,
        color: Colors.white,
        align: Alignment.center,
      ),
    );
  }
}
