import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/create_exercise/exercise_cubit.dart';
import 'package:sculpt/bloc/list_routine/list_routine_cubit.dart';
import 'package:sculpt/infrastructure/datasource/exercise.dart';
import 'package:sculpt/infrastructure/persistence/injections.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/services/notification_service.dart';

import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/errors/empty.dart';
import 'package:sculpt/presentation/ui_kit/tiles/routine_tile.dart';

class RoutineListScreen extends StatefulWidget {
  const RoutineListScreen({super.key});

  @override
  State<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  final notificationService = NotificationService();
  @override
  void initState() {
    context.read<ListRoutineCubit>().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ExerciseCubit(ExerciseDatasource(db: sl.get<IsarDatabase>()));
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: UIKitColors.primaryColor,
        appBar: defaultAppBar(context, "Routines list"),
        body: SafeArea(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Timer.periodic(Duration(seconds: 1), (timer) {
                    if (timer.tick == 10) {
                      timer.cancel();
                    }
                  });
                },
                child: Text("Show notification"),
              ),
              TextButton(
                onPressed: () {
                  notificationService.cancelNotification(1);
                },
                child: Text("Cancel notification"),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: BlocBuilder<ListRoutineCubit, ListRoutineState>(
                    builder: (context, state) {
                      if (state.routines == null || state.routines!.isEmpty) {
                        return const EmptyListMessage(title: "No routines avvailable");
                      }
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ...state.routines!.map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: RoutineTile(routine: e))),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
