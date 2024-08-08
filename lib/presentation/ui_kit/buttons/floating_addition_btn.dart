import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class FloatingAdditionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final double? iconSize;
  const FloatingAdditionButton({
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
        padding: const EdgeInsets.all(20),
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
