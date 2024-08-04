import 'package:go_router/go_router.dart';
import 'package:sculpt/presentation/screens/dashboard.dart';
import 'package:sculpt/presentation/screens/routine/create/create_routine.dart.dart';
import 'package:sculpt/presentation/screens/routine/routine_list.dart';
import 'package:sculpt/presentation/screens/routine/workout/workout_list.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/routine/create',
      builder: (context, state) => const CreateRoutineScreen(),
    ),
    GoRoute(
      path: '/routines',
      builder: (context, state) => const RoutineListScreen(),
    ),
    GoRoute(
      path: '/workouts',
      builder: (context, state) => const WorkoutListScreen(),
    ),
  ],
);
