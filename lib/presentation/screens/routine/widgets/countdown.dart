import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/models/progress.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

import 'dart:math' as math;

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CountDown extends StatelessWidget {
  final Exercise exercise;
  final int secondsAfter;
  const CountDown({
    super.key,
    required this.exercise,
    required this.secondsAfter,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ExerciseProgress(
      exercise: exercise,
      currentSeconds: secondsAfter,
    );
    final width = MediaQuery.of(context).size.width;
    final secondsProgress = progress.totalSeconds - progress.currentSeconds!;
    return SleekCircularSlider(
      initialValue: 100 - progress.currentPercentage,
      appearance: CircularSliderAppearance(
        startAngle: 0,
        angleRange: 360,
        animationEnabled: false,
        size: width,
        infoProperties: InfoProperties(),
        customWidths: CustomSliderWidths(trackWidth: 0, shadowWidth: 0, handlerSize: 0, progressBarWidth: 20),
        customColors: CustomSliderColors(
          trackColor: Colors.transparent,
          progressBarColor: UIKitColors.secondaryFgColor,
        ),
      ),
      innerWidget: (percentage) => Center(
        child: Text(
          "$secondsProgress",
          style: TextStyle(color: UIKitColors.white, fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
