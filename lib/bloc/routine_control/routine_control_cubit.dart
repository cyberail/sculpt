import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/datasource/routine.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

part 'routine_control_state.dart.dart';

class RoutineControlCubit extends Cubit<RoutineControlState> {
  RoutineControlCubit({required RoutineDatasource datasource})
      : _datasource = datasource,
        super(RoutineControlState());

  late final RoutineDatasource _datasource;

  bool hasEnded(Routine routine, RestType? restType) {
    if (state.currentExerciseIndex != null) {
      final exercise = routine.exercises[state.currentExerciseIndex!];
      if (restType != null) {
        if (restType == RestType.between && state.secondsPassed == exercise.repsRestMin! * 60) {
          return true;
        } else if (restType == RestType.after && state.secondsPassed == exercise.restAfterMin! * 60) {
          return true;
        } else {
          return false;
        }
      } else if (state.secondsPassed == exercise.time * 60) {
        return true;
      }
    }

    return false;
  }

  bool exerciseExists(Routine routine, int index) {
    if (routine.exercises.length - 1 >= index) {
      return true;
    }

    return false;
  }

  int? findNextExercise(Routine routine, int index) {
    if (exerciseExists(routine, index)) {
      return index;
    }
    return null;
  }

  Future<void> playSound({required String asset}) async {
    final player = AudioPlayer();
    await player.play();
    player.dispose();
  }

  Future<void> playGetReadySound() async => playSound(asset: "assets/are_you_ready.wav");

  Future<void> playReadySound() async => playSound(asset: "assets/ready.wav");

  Future<void> playGoSound() async => playSound(asset: "assets/go.wav");

  Future<void> playFinishSound() async => playSound(asset: "assets/finish.mp3");

  bool isLastExercise(Routine routine) {
    if (state.currentExerciseIndex! >= routine.exercises.length - 1) {
      return true;
    }
    return false;
  }

  Future<void> restartSet(int? tried, {bool restartExercise = false}) async {
    state.timer?.cancel();
    final currentExercise = state.currentExercise;
    final currentRoutine = state.routine;
    if (currentExercise == null || currentRoutine == null) {
      return;
    }
    final currentExerciseClone = Exercise.clone(currentExercise);

    if (tried != null) {
      currentExerciseClone.tried = restartExercise == true ? 0 : tried - 1;
    }

    start(
      currentRoutine,
      currentExercise: currentExerciseClone,
      newIndex: state.currentExerciseIndex,
    );
  }

  void _speak(String text) async {
    final flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setSpeechRate(0.35);
    await flutterTts.getDefaultEngine;
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-AU"});
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void start(
    Routine routine, {
    int? newIndex,
    Exercise? currentExercise,
    RestType? restType,
  }) async {
    int currentExerciseIndex = newIndex ?? 0;
    if (!exerciseExists(routine, currentExerciseIndex)) {
      emit(state.copyWith(event: RoutineEvent.stopped));
      return;
    }
    final exercise = currentExercise ?? Exercise.clone(routine.exercises[currentExerciseIndex]);
    if (exercise.type == WorkoutType.reps && restType == null) {
      exercise.tried += 1;
      emit(state.copyWith(
        currentExerciseIndex: currentExerciseIndex,
        currentExercise: exercise,
        event: RoutineEvent.started,
      ));
      return;
    }
    emit(state.copyWith(routine: routine));
    if (state.timer != null) {
      state.timer?.cancel();
    }

    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restType == RestType.after && timer.tick == 2) {
        if (exerciseExists(routine, currentExerciseIndex + 1)) {
          final nextExercise = routine.exercises[currentExerciseIndex + 1];
          _speak(
              "Next exercise: ${nextExercise.name}. \n ${nextExercise.sets} Sets. ${nextExercise.isRepSets ? nextExercise.reps : (nextExercise.time * 60).round()} ${nextExercise.isRepSets ? 'Reps ' : 'Seconds'} each set.");
        }
      }
      emit(state.copyWith(
        event: RoutineEvent.tick,
        secondsPassed: timer.tick,
        restType: restType,
        timer: timer,
      ));

      if (restType != null && exercise.getResTimeSeconds(restType) - timer.tick == 15) {
        playReadySound();
      }

      if (restType != null && exercise.getResTimeSeconds(restType) - timer.tick == 5) {
        playGetReadySound();
      }

      if (restType != null && exercise.getResTimeSeconds(restType) - timer.tick == 0) {
        playGoSound();
      }
      if (hasEnded(routine, restType)) {
        if (restType == null) {
          playFinishSound();
        }
        if (restType == RestType.after) {
          emit(state.copyWith(
            secondsPassed: 0,
            timer: null,
            event: RoutineEvent.exerciseFinished,
          ));
          timer.cancel();
          return;
        }

        print("=== timereps ${exercise.tried}");

        if (restType == null) {
          exercise.tried += 1;
        }

        if (exercise.tried >= exercise.sets!) {
          emit(state.copyWith(
            secondsPassed: 0,
            timer: null,
          ));
          if (isLastExercise(routine)) {
            emit(state.copyWith(event: RoutineEvent.fullyFinished));
            timer.cancel();
            return;
          }

          start(
            routine,
            newIndex: currentExerciseIndex,
            currentExercise: exercise,
            restType: RestType.after,
          );

          timer.cancel();
          return;
        }

        emit(state.copyWith(
          secondsPassed: 0,
          timer: null,
        ));
        if (restType != null) {
          start(
            routine,
            newIndex: currentExerciseIndex,
            currentExercise: exercise,
          );
        } else {
          start(
            routine,
            newIndex: currentExerciseIndex,
            currentExercise: exercise,
            restType: RestType.between,
          );
        }

        timer.cancel();
      }
    });
    emit(state.copyWith(
      status: RoutineStatus.playing,
      event: RoutineEvent.started,
      timer: timer,
      currentExerciseIndex: currentExerciseIndex,
    ));
  }

  Future<void> stop() async {
    if (state.timer != null) {
      state.timer?.cancel();
      emit(
        RoutineControlState(
          routine: state.routine,
          event: RoutineEvent.stopped,
          status: RoutineStatus.initial,
          timer: null,
        ),
      );
    }
  }
}
