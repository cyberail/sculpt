import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class ResizableFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final double? iconSize;
  const ResizableFloatingButton({
    super.key,
    required this.onTap,
    this.color = UIKitColors.secondaryFgColor,
    this.icon = Icons.add,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(60)),
        child: Icon(
          icon,
          size: iconSize,
          color: UIKitColors.white,
        ),
      ),
    );
  }
}
