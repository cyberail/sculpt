import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sculpt/models/workout.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/tiles/routine_tile.dart';

class RoutineListScreen extends StatelessWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Routines list"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoutineTile(
              name: 'Monday',
              timeMinutes: 57,
              exercises: [WorkOut(), WorkOut(), WorkOut(), WorkOut(), WorkOut(), WorkOut()],
            ),
          ],
        ),
      ),
    );
  }
}
