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
    return InkWell(
      onTap: onTap,
      radius: 20,
      child: Icon(
        icon,
        color: UIKitColors.white,
        size: 25,
      ),
    );
  }
}
