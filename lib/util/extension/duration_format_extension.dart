extension DurationFormatExtension on Duration {
  String get minutesSeconds =>
      // ignore: prefer_interpolation_to_compose_strings
      '${inMinutes.toString().padLeft(2, '0')}:' +
      inSeconds.remainder(Duration.minutesPerHour).toString().padLeft(2, '0');
}
