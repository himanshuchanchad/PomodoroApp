import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/play_audio.dart';

class CurrentTimer with ChangeNotifier {
  int id;
  String _title = "";
  String _shortDescription = "";
  int _noOfSessions = 6;
  int _currentSession = 0;

  int _minuteVal = 45;
  int _second = 0;
  int _minuteWorkTimer = 45;
  int _minuteBreakTimer = 15;

  int _totalWorkTime = 0;
  int _totalBreakTime = 0;

  bool _workOrBreak = true;
  bool _startOrStop = false;

  String _timerString = '';
  Timer _everySecond;
  PlayAudio _playAudio = PlayAudio();

  CurrentTimer() {
    getDefaultVal();
  }
  // getter
  int get minuteVal => _minuteVal;
  int get second => _second;
  int get minuteWorkTimer => _minuteWorkTimer;
  int get minuteBreakTimer => _minuteBreakTimer;
  int get noOfSessions => _noOfSessions;
  int get totalWorkTime => _totalWorkTime;
  int get totalBreakTime => _totalBreakTime;

  bool get flag => _startOrStop;
  bool get workorBreakStatus => _workOrBreak;

  String get timerString => _timerString;
  String get title => _title;
  String get shortDescription => _shortDescription;

  void getDefaultVal() async {
    setTimerString();
  }

  // setter
  void loadTask(
      int id,
      String title,
      String shortDescription,
      int minuteWorkTimer,
      int minuteBreakTimer,
      int noOfSessions,
      int currentSession,
      int totalWorkTime,
      int totaBreakTime) {
      id = id;
      _title = title;
      _shortDescription = shortDescription;
      _minuteWorkTimer = minuteWorkTimer;
      _minuteBreakTimer = minuteBreakTimer;
      _noOfSessions = noOfSessions;
      _currentSession = currentSession;
      _totalWorkTime = totalWorkTime;
      _totalBreakTime = totaBreakTime;
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
    _noOfSessions = value;
    notifyListeners();
  }

  void toggleflag() {
    _startOrStop = !_startOrStop;
    notifyListeners(); // Remove comments only if it's used change from reset
  }

  void reset() {
    if (_workOrBreak) {
      // TODO logic improve
      _totalWorkTime += _minuteWorkTimer.toInt() - _minuteVal;
      _minuteVal = _minuteBreakTimer.toInt();
    } else {
      //TODO logic improve
      _totalBreakTime += _minuteBreakTimer.toInt() - _minuteVal;
      _minuteVal = _minuteWorkTimer.toInt();
    }
    _workOrBreak = !_workOrBreak;
    _currentSession++;
    _second = 00;
    stopTimer();
    // _startOrStop = false;
    setTimerString();
    notifyListeners();
  }

  void subtract(Timer _everySecond, BuildContext context) {
    if (_second == 0) {
      _minuteVal = _minuteVal - 1;
      _second = 19;
      // TODO 19 for debugging
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
    } catch (e) {}
    _everySecond = null;
    _startOrStop = false;
    notifyListeners();
  }
}
