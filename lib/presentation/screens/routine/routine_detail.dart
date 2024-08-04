import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class RoutineDetailScreen extends StatelessWidget {
  final String? routineId;
  const RoutineDetailScreen({super.key, this.routineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Routine detail"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
