import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_of_life/feature/pomodoro/pomodoro.dart';
import 'package:game_of_life/util/util.dart';

class PomodoroFullscreenView extends StatefulWidget {
  const PomodoroFullscreenView({required this.pomodoro, super.key});

  final Pomodoro pomodoro;

  @override
  State<PomodoroFullscreenView> createState() => _PomodoroFullscreenViewState();
}

class _PomodoroFullscreenViewState extends State<PomodoroFullscreenView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    createTicker((_) {
      widget.pomodoro.update();
      setState(() {});
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            onPressed: () => {},
            iconSize: 40,
            icon: const Icon(Icons.settings),
          ),
        ),
        switch (widget.pomodoro.currentState) {
          PomodoroState.stopped => _stoppedContent(),
          PomodoroState.running || PomodoroState.paused => _runningContent(),
        },
      ],
    );
  }

  Widget _stoppedContent() => Center(
        child: LayoutBuilder(
          builder: (context, constraints) => IconButton(
            onPressed: () {
              widget.pomodoro.start();
              setState(() {});
            },
            iconSize:
                math.min(constraints.maxHeight, constraints.maxWidth) * 0.75,
            icon: const Icon(Icons.play_circle),
          ),
        ),
      );

  Widget _runningContent() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.pomodoro.timeLeft.minutesSeconds),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    widget.pomodoro.currentState == PomodoroState.paused
                        ? widget.pomodoro.resume()
                        : widget.pomodoro.pause();
                    setState(() {});
                  },
                  icon: Icon(
                    widget.pomodoro.currentState == PomodoroState.paused
                        ? Icons.play_circle
                        : Icons.pause_circle,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.pomodoro.stop();
                    setState(() {});
                  },
                  icon: const Icon(Icons.stop_circle),
                ),
              ],
            ),
          ],
        ),
      );
}
