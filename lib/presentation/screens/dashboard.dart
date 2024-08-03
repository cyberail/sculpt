import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/large_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Dashboard", enableBackButton: false),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeBtn(
              label: "Routines",
              icon: Icons.schedule,
              onTap: () => context.push("/routines"),
            ),
            const SizedBox(height: 50),
            LargeBtn(
              label: "Create Routine",
              icon: Icons.add,
              onTap: () => context.push("/routine/create"),
            ),
          ],
        ),
      ),
    );
  }
}
