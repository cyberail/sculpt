import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

abstract class UiKitSnackBars {
  static SnackBar error(context, {required String label}) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: UIKitColors.secondaryFgColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.priority_high,
              color: UIKitColors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              label,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: UIKitColors.white,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 20,
      ),
    );
  }

  static SnackBar success(context, {required String label}) {
    return SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: UIKitColors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.check,
              color: UIKitColors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              label,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: UIKitColors.white,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 20,
      ),
    );
  }
}
