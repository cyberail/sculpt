import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/progress_indicator.dart';

class UIKitIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool loading;
  final bool disabled;
  const UIKitIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.disabled = false,
    this.loading = false,
  });

  VoidCallback? get _onTap => !loading && !disabled ? onTap : null;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(
        width: 25,
        height: 25,
        child: Progress(),
      );
    }
    return Material(
      color: Colors.transparent, // Ensures the Material widget is transparent
      child: InkWell(
        onTap: _onTap,
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
