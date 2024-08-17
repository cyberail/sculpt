// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class LoadingStopButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onDoubleTap;
  const LoadingStopButton({
    Key? key,
    required this.onTap,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: UIKitColors.secondaryFgColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(70),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox.expand(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: UIKitColors.white.withOpacity(0.5),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.stop, color: UIKitColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
