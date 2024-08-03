import 'package:flutter/widgets.dart';

abstract class Validators {
  static String? emptyTextValidation(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "Please fill this field";
    }

    return null;
  }
}
