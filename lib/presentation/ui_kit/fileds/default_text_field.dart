import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final String hintText;

  const DefaultTextField({
    super.key,
    required this.validator,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: TextStyle(color: UIKitColors.white),
      decoration: InputDecoration(
        labelText: label,
        hintStyle: TextStyle(color: UIKitColors.grey),
        hintText: hintText,
        labelStyle: TextStyle(color: UIKitColors.white, fontSize: 15),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: UIKitColors.white, width: 2)),
      ),
      validator: validator,
    );
  }
}
