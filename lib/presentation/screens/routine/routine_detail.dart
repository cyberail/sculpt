import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/create_exercise/exercise_cubit.dart';
import 'package:sculpt/bloc/routine/routine_cubit.dart';
import 'package:sculpt/infrastructure/datasource/exercise.dart';
import 'package:sculpt/infrastructure/persistence/injections.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/exercise/create_exercise.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/floating_addition_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/errors/empty.dart';
import 'package:sculpt/presentation/ui_kit/tiles/exercise_tile.dart';

class RoutineDetailScreen extends StatelessWidget {
  final Routine routine;
  const RoutineDetailScreen({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(context, "Routine: ${routine.name} "),
          floatingActionButton: FloatingAdditionButton(onTap: () {
            final cubit = ExerciseCubit(ExerciseDatasource(db: sl.get<IsarDatabase>()));
            showModalBottomSheet(
              context: context,
              backgroundColor: UIKitColors.primaryColor,
              builder: (_) => BlocProvider(
                create: (_) => cubit,
                child: CreateExercise(routine: routine),
              ),
              showDragHandle: true,
              useSafeArea: true,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            );
          }),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _checkAndBuild(),
          ),
        );
      },
    );
  }

  Widget _checkAndBuild() {
    if (routine.exercises.isEmpty) {
      return const EmptyListMessage(
        title: "There are no exercises in this routine.",
        subtitle: "Add by tapping the add button.",
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ...routine.exercises.map((exercise) {
          return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: ExerciseTile(exercise: exercise));
        })
      ],
    );
  }
}
