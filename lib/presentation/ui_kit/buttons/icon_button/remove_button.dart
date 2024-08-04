// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sculpt/presentation/ui_kit/buttons/icon_button/icon_button.dart';

class UIKitRemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  const UIKitRemoveButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UIKitIconButton(
      onTap: onTap,
      icon: Icons.delete,
    );
  }
}
