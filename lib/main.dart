import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/list_routine/list_routine_cubit.dart';
import 'package:sculpt/bloc/routine/routine_cubit.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/infrastructure/datasource/routine.dart';
import 'package:sculpt/infrastructure/event_manager/bus.dart';
import 'package:sculpt/infrastructure/persistence/injections.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/services/notification_service.dart';
import 'package:sculpt/presentation/router/router.dart';
import 'package:sculpt/presentation/ui_kit/progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  final eventBus = Buss();
  final granted = await notificationService.requestPermissions();
  if (granted == false) exit(0);

  await notificationService.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return FutureBuilder(
        future: setUpDatabase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Progress();
          }

          final routineCubit = RoutineCubit(
            RoutineDatasource(db: sl.get<IsarDatabase>()),
          );

          final routineListCubit = ListRoutineCubit(
            RoutineDatasource(db: sl.get<IsarDatabase>()),
          );

          final routineControlCubit = RoutineControlCubit(
            datasource: RoutineDatasource(db: sl.get<IsarDatabase>()),
          );

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => routineCubit,
              ),
              BlocProvider(
                create: (context) => routineListCubit,
              ),
              BlocProvider(
                create: (context) => routineControlCubit,
              ),
            ],
            child: MaterialApp.router(
              routerConfig: router,
            ),
          );
        });
  }
}
