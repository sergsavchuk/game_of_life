import 'package:game_of_life/feature/pomodoro/logic/pomodoro_logic.dart';

abstract class Pomodoro {
  Pomodoro(this.config);

  final PomodoroConfig config;

  void start();

  void stop();

  void pause();

  void resume();

  void update();

  PomodoroState get currentState;

  PomodoroIntervalType get currentIntervalType;

  Duration get timeLeft;
}
