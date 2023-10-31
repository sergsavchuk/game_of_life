import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pomodoro_config.freezed.dart';

@freezed
class PomodoroConfig with _$PomodoroConfig {
  const factory PomodoroConfig({
    required Duration intervalDuration,
    required Duration pauseDuration,
    required VoidCallback onIntervalStart,
    required VoidCallback onPauseStart,
  }) = _PomodoroConfig;
}
