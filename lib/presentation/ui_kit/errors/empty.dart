import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class EmptyListMessage extends StatelessWidget {
  final String title;
  final String? subtitle;
  const EmptyListMessage({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(color: UIKitColors.white, fontSize: 20),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(color: UIKitColors.secondaryFgColor, fontSize: 16),
            ),
        ],
      ),
    );
  }
}
