import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/models/progress.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

import 'dart:math' as math;

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CountDown extends StatefulWidget {
  final Exercise exercise;
  final int secondsAfter;
  final RestType? restType;
  const CountDown({
    super.key,
    required this.exercise,
    required this.secondsAfter,
    this.restType,
  });

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with TickerProviderStateMixin {
  late AnimationController _greenController;
  late AnimationController _redController;

  late Animation<Color?> _greenAnimation;
  late Animation _redAnimation;

  void setGreenAnimation() {}

  void setRedAnimation() {}

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _greenController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _redController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _redAnimation = ColorTween(
      begin: UIKitColors.secondaryFgColor,
      end: UIKitColors.redGlow, // Change this to the desired glow effect
    ).animate(_redController);

    _greenAnimation = ColorTween(
      begin: UIKitColors.green,
      end: UIKitColors.greenGlow, // Change this to the desired glow effect
    ).animate(_greenController);
  }

  @override
  void dispose() {
    _redController.dispose();
    _greenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ExerciseProgress(
      exercise: widget.exercise,
      currentSeconds: widget.secondsAfter,
      restType: widget.restType,
    );
    final width = MediaQuery.of(context).size.width;
    final secondsProgress = progress.totalSeconds - progress.currentSeconds!;
    print(progress.currentPercentage);
    print("$secondsProgress");
    return AnimatedBuilder(
        animation: widget.restType == null ? _redAnimation : _greenAnimation,
        builder: (animation, context) {
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
                progressBarColor: widget.restType == null ? _redAnimation.value : _greenAnimation.value,
              ),
            ),
            innerWidget: (percentage) => Center(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$secondsProgress",
                      style: TextStyle(
                        color: widget.restType == null ? _redAnimation.value : _greenAnimation.value,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          widget.restType != null ? "Resting" : "${widget.exercise.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.restType == null ? _redAnimation.value : _greenAnimation.value,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
