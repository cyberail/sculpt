import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

abstract class Utils {
  static Future<bool> showAlertDialog(BuildContext context, String message) async {
    // set up the buttons
    Widget cancelButton = InkWell(
      onTap: () {
        // returnValue = false;
        context.pop(false);
      },
      child: Text(
        "No",
        style: TextStyle(
          color: UIKitColors.secondaryFgColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
    Widget continueButton = InkWell(
      child: Text(
        "Yes",
        style: TextStyle(color: UIKitColors.green, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onTap: () {
        // returnValue = true;
        context.pop();
        context.pop();
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: UIKitColors.black,
      title: Text(
        "Do you want to continue?",
        style: TextStyle(color: UIKitColors.white, fontWeight: FontWeight.bold),
      ),
      content: Text(
        message,
        style: TextStyle(color: UIKitColors.white),
      ),
      actions: [
        cancelButton,
        const SizedBox(width: 10),
        continueButton,
      ],
    ); // show the dialog
    final result = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return result ?? false;
  }
}
