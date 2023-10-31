import 'package:flutter/material.dart';
import 'package:game_of_life/feature/pomodoro/pomodoro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Life',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: PomodoroFullscreenView(
            pomodoro: DateTimePomodoro(
              PomodoroConfig(
                intervalDuration: const Duration(minutes: 25),
                pauseDuration: const Duration(minutes: 5),
                onIntervalStart: () => {},
                onPauseStart: () => {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
