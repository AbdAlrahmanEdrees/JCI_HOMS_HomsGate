import 'package:flutter/material.dart';
class CoustomTextFormField extends StatelessWidget {
  final String? hint;
  final String? colorhint;
  final void Function(String?)? onsaved;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  const CoustomTextFormField({super.key, this.hint,  this.colorhint,  this.onsaved, this.validator,  this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onsaved,
      validator: validator,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          fillColor: Colors.white
      ),

    );
  }
}
