import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class LargeBtn extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onTap;
  final Color fgColor;
  const LargeBtn({
    super.key,
    this.icon,
    required this.label,
    this.onTap,
    this.fgColor = UIKitColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: UIKitColors.secondaryColor,
            border: Border.all(color: UIKitColors.white, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: fgColor),
                textAlign: TextAlign.center,
              ),
            ),
            if (icon != null) Icon(icon, color: fgColor),
          ],
        ),
      ),
    );
  }
}
