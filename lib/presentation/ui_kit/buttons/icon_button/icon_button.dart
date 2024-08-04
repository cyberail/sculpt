import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class UIKitIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const UIKitIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Ensures the Material widget is transparent
      child: InkWell(
        onTap: onTap,
        splashFactory: InkSplash.splashFactory,
        radius: 40,
        borderRadius: BorderRadius.circular(40),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            color: UIKitColors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
