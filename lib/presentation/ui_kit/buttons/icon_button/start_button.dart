import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/buttons/icon_button/icon_button.dart';

class UIKitStartButton extends StatelessWidget {
  final VoidCallback onTap;
  const UIKitStartButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UIKitIconButton(
      onTap: onTap,
      icon: Icons.play_circle,
    );
  }
}
