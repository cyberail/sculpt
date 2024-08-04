import 'package:flutter/material.dart';
import 'package:sculpt/infrastructure/persistence/injections.dart';
import 'package:sculpt/presentation/router/router.dart';
import 'package:sculpt/presentation/screens/dashboard.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/progress_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setUpDatabase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Progress();
          }
          return MaterialApp.router(
            routerConfig: router,
          );
        });
  }
}
