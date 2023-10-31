import 'package:game_of_life/feature/pomodoro/logic/pomodoro_logic.dart';

class DateTimePomodoro extends Pomodoro {
  DateTimePomodoro(super.config);

  DateTime? _prevTime;

  Duration _runningTime = Duration.zero;

  bool _paused = false;

  @override
  PomodoroIntervalType get currentIntervalType =>
      _runningTime.inMilliseconds % _wholeCycleMs <
              config.intervalDuration.inMilliseconds
          ? PomodoroIntervalType.pomodoro
          : PomodoroIntervalType.breakk;

  @override
  PomodoroState get currentState {
    if (_prevTime == null) {
      return PomodoroState.stopped;
    }

    return _paused ? PomodoroState.paused : PomodoroState.running;
  }

  @override
  void start() {
    if (currentState != PomodoroState.stopped) {
      return;
    }

    _prevTime = _now();
  }

  @override
  void stop() {
    _paused = false;
    _prevTime = null;
    _runningTime = Duration.zero;
  }

  @override
  void update() {
    final prevTime = _prevTime;
    if (prevTime == null || _paused) {
      return;
    }

    final prevInterval = currentIntervalType;
    final now = _now();
    _runningTime += now.difference(prevTime);
    _prevTime = now;

    if (prevInterval != currentIntervalType) {
      prevInterval == PomodoroIntervalType.pomodoro
          ? config.onPauseStart.call()
          : config.onIntervalStart.call();
    }
  }

  @override
  void pause() {
    _paused = true;
  }

  @override
  void resume() {
    _paused = false;
    _prevTime = _now();
  }

  @override
  Duration get timeLeft => currentIntervalType == PomodoroIntervalType.pomodoro
      ? Duration(
          milliseconds: config.intervalDuration.inMilliseconds - _cycleLeft,
        )
      : Duration(milliseconds: _wholeCycleMs - _cycleLeft);

  DateTime _now() => DateTime.now();

  int get _wholeCycleMs =>
      config.intervalDuration.inMilliseconds +
      config.pauseDuration.inMilliseconds;

  int get _cycleLeft => _runningTime.inMilliseconds % _wholeCycleMs;
}
