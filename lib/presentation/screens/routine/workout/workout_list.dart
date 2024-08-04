import 'package:flutter/material.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Workout list"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
