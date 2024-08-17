import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

AppBar defaultAppBar(BuildContext context, String title,
        {bool enableBackButton = true, IconData? icon, VoidCallback? onTap, Widget? rightSideWidget}) =>
    AppBar(
      leading: enableBackButton
          ? IconButton(
              icon: Icon(icon ?? Icons.arrow_back),
              onPressed: onTap ?? context.pop,
              color: UIKitColors.white,
            )
          : null,
      backgroundColor: UIKitColors.primaryColor,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      elevation: 0,
      actions: [if (rightSideWidget != null) rightSideWidget],
    );
