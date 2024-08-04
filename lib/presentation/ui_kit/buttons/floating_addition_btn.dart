import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class FloatingAdditionButton extends StatelessWidget {
  final VoidCallback onTap;
  const FloatingAdditionButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: UIKitColors.secondaryFgColor,
      child: const Icon(
        Icons.add,
        color: UIKitColors.white,
      ),
    );
  }
}
