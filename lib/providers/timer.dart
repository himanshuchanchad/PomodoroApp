import 'package:PomodoroApp/providers/task.dart';
import 'package:PomodoroApp/utils/priority.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../utils/play_audio.dart';
import '../models/task_item.dart';

class CurrentTimer with ChangeNotifier {
  TaskItem task;
  int _minuteVal = 45;
  int _second = 0;

  bool _workOrBreak = true;
  bool _startOrStop = false;

  String _timerString = '';
  Timer _everySecond;
  PlayAudio _playAudio = PlayAudio();

  CurrentTimer() {
    // TODO last running one which is not finished
    this.task = TaskItem(
      id: null,
      minuteBreakTimer: 15,
      minuteWorkTimer: 45,
      noOfSessions: 6,
      priority: Priority.Low,
      shortDescription: "",
      title: "Untitled",
    );
    getDefaultVal();
  }
  // getter
  int get minuteVal => _minuteVal;
  int get second => _second;
  int get minuteWorkTimer => task.minuteWorkTimer;
  int get minuteBreakTimer => task.minuteBreakTimer;
  int get noOfSessions => task.noOfSessions;
  int get totalWorkTime => task.totalWorkTime;
  int get totalBreakTime => task.totalBreakTime;
  int get currentSession => task.currentSession;

  bool get flag => _startOrStop;
  bool get workorBreakStatus => _workOrBreak;

  String get timerString => _timerString;
  String get title => task.title;
  String get shortDescription => task.shortDescription;

  Priority get priority => task.priority;

  void getDefaultVal() async {
    setTimerString();
  }

  // setter
  void loadTask(TaskItem task) {
    // TODO save the last running or completed one
    this.task = task;
    notifyListeners();
  }

  void setTimerString() {
    if (_second < 10) {
      _timerString = "$_minuteVal:0$_second";
    } else {
      _timerString = "$_minuteVal:$_second";
    }
  }

  void setNoOfSessions(int value) {
    task.noOfSessions = value;
    notifyListeners();
  }

  void setCurrentSession(int value) {
    task.currentSession = value;
    notifyListeners();
  }

  void toggleflag() {
    _startOrStop = !_startOrStop;
    notifyListeners(); // Remove comments only if it's used change from reset
  }

  void reset() {
    if (_workOrBreak) {
      _minuteVal = task.minuteBreakTimer.toInt();
      task.currentSession++;
      if (task.currentSession == task.noOfSessions) {
        // need to show something that it is done
        task.toggleTaskStatus();
      }
    } else {
      _minuteVal = task.minuteWorkTimer.toInt();
    }
    _workOrBreak = !_workOrBreak;
    _second = 00;
    stopTimer();
    // _startOrStop = false;
    setTimerString();
    notifyListeners();
  }

  void subtract(Timer _everySecond, BuildContext context) {
    if (_second == 0) {
      _minuteVal = _minuteVal - 1;
      _second = 59;
      if (_workOrBreak) {
        task.totalWorkTime++;
      } else {
        task.totalBreakTime++;
      }
      if (_minuteVal < 0) {
        reset();
        _playAudio.play();
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Title(
                    color: Colors.white,
                    child: Text("Take a break/start to work")),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        _playAudio.stop();
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    } else {
      _second = _second - 1;
    }
    setTimerString();
    notifyListeners();
  }

  void startTimer(BuildContext context) {
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      subtract(_everySecond, context);
    });
    _startOrStop = true;
    notifyListeners();
  }

  void stopTimer() {
    try {
      _everySecond.cancel();
    } catch (e) {
      print("error occured ");
    }
    _everySecond = null;
    _startOrStop = false;
    notifyListeners();
  }
}
