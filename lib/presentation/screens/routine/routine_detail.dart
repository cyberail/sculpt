import 'package:flutter/material.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/floating_addition_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class RoutineDetailScreen extends StatelessWidget {
  final Routine routine;
  const RoutineDetailScreen({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Routine: ${routine?.name} "),
      floatingActionButton: FloatingAdditionButton(onTap: () {}),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
            children: routine.exercises.map((e) {
          return Container();
        }).toList()),
      ),
    );
  }
}
