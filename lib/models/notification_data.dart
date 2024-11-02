// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/models/notification_progress.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class NotificationData {
  NotificationProgress? progress;
  Exercise? workout;
  Exercise? nextWorkout;
  RestType? restType;

  NotificationData({
    this.progress,
    this.workout,
    this.restType,
    this.nextWorkout,
  });

  WorkoutType? get workoutType => workout?.type;

  String get title {
    final color = UIKitColors.redGlow;
    if (restType == RestType.between) return "<span style='color:${UIKitColors.green.htmlHex};'>Resting between</span>";
    if (restType == RestType.after) return "<span style='color:${UIKitColors.green.htmlHex};'>Resting after</span>";

    return "<span style='color:${UIKitColors.secondaryFgColor.htmlHex}'>${workout?.name ?? ''}</span>";
  }

  String get body {
    if (restType == RestType.between) return "";
    if (restType == RestType.after && nextWorkout != null) return "Coming up: <b>${nextWorkout?.name}</b>";

    final currentTry = (workout?.tried ?? 0) + 1;
    String result = "";
    result += "current set: <b>$currentTry</b>";
    if (workoutType == WorkoutType.reps) {
      result += "<br> reps: <b>${workout?.reps ?? ''}</b>";
    }

    return result;
  }

  NotificationData updateProgress() {
    if (progress == null) {
      return this;
    }
    return copyWith(progress: progress!.copyWith(progress: progress!.progress + 1));
  }

  NotificationData copyWith({
    NotificationProgress? progress,
    Exercise? workout,
    Exercise? nextWorkout,
    RestType? restType,
  }) {
    return NotificationData(
      progress: progress ?? this.progress,
      workout: workout ?? this.workout,
      nextWorkout: nextWorkout ?? this.nextWorkout,
      restType: restType ?? this.restType,
    );
  }
}
