import 'dart:async';
import 'package:behalal/app/universal_utils/timer/timer_controller.dart';
import 'package:flutter/widgets.dart';


class CustomCountDown extends StatefulWidget {
  final int seconds;
  final Widget Function(BuildContext, double) build;
  final Function? onFinished;
  final Duration interval;
  final CountdownController? controller;
  const CustomCountDown({
    Key? key,
    required this.seconds,
    required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
  }) : super(key: key);

  @override
  _CustomCountDownState createState() => _CustomCountDownState();
}
class _CustomCountDownState extends State<CustomCountDown> {
  final int _secondsFactor = 1000000;
  Timer? _timer;
  bool _onFinishedExecuted = false;
  late int _currentMicroSeconds;

  @override
  void initState() {
    _currentMicroSeconds = widget.seconds * _secondsFactor;
    widget.controller?.setOnStart(_startTimer);
    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.isCompleted = false;

    if (widget.controller == null || widget.controller!.autoStart == true) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(CustomCountDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.seconds != widget.seconds) {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(
      context,
      _currentMicroSeconds / _secondsFactor,
    );
  }

  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void _onTimerResumed() {
    _startTimer();
  }

  void _onTimerRestart() {
    widget.controller?.isCompleted = false;
    _onFinishedExecuted = false;

    setState(() {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    });

    _startTimer();
  }

  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer!.cancel();

      widget.controller?.isCompleted = true;
    }

    if (_currentMicroSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
            (Timer timer) {
          if (_currentMicroSeconds <= 0) {
            timer.cancel();

            if (widget.onFinished != null) {
              widget.onFinished!();
              this._onFinishedExecuted = true;
            }
            widget.controller?.isCompleted = true;
          } else {
            this._onFinishedExecuted = false;
            setState(() {
              _currentMicroSeconds =
                  _currentMicroSeconds - widget.interval.inMicroseconds;
            });
          }
        },
      );
    } else if (!this._onFinishedExecuted) {
      if (widget.onFinished != null) {
        widget.onFinished!();
        this._onFinishedExecuted = true;
      }
      widget.controller?.isCompleted = true;
    }
  }
}


String getTimeForCountDown(int time) {
  int minute = (time / 60).floor();
  int seconds = time % 60;
  String one = minute < 10 ? '0$minute' : '$minute';
  String two = seconds < 10 ? '0$seconds' : '$seconds';
  return "$one:$two";
}