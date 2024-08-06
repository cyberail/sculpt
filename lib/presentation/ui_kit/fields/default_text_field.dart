import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final String hintText;
  final TextInputType? inputType;

  const DefaultTextField({
    super.key,
    required this.validator,
    required this.label,
    required this.hintText,
    required this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: const TextStyle(color: UIKitColors.white),
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        hintStyle: const TextStyle(color: UIKitColors.grey),
        hintText: hintText,
        labelStyle: const TextStyle(color: UIKitColors.white, fontSize: 15),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: UIKitColors.white, width: 2)),
      ),
      validator: validator,
    );
  }
}
