// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sculpt/presentation/ui_kit/buttons/icon_button/icon_button.dart';

class UIKitRemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool loading;
  final bool disabled;
  const UIKitRemoveButton({
    Key? key,
    required this.onTap,
    this.loading = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UIKitIconButton(
      loading: loading,
      disabled: disabled,
      onTap: onTap,
      icon: Icons.delete,
    );
  }
}
