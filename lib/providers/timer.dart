import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/play_audio.dart';

class CurrentTimer with ChangeNotifier {
  int _minuteVal = 45;
  int _second = 0;

  int _defaultMinuteVal = 45;
  Timer _everySecond;
  int _defaultShortbreak = 15;
  int _shortbreak = 15;
  int _noOfSessions = 6;

  String _timerString = '';
  bool _startOrStop = false;
  bool _workOrBreak = true;
  int _totalWorkTime = 0;
  int _totalBreakTime = 0;

  PlayAudio _playAudio = PlayAudio();

  CurrentTimer() {
    getDefaultVal();
  }
  // getter
  int get defaultMinuteVal => _defaultMinuteVal;
  int get minuteVal => _minuteVal;
  int get second => _second;
  int get shortBreak => _shortbreak;
  int get defaultShortBreak => _defaultShortbreak;
  int get noOfSessions => _noOfSessions;
  bool get flag => _startOrStop;
  bool get workorBreakStatus => _workOrBreak;
  String get getTimerString => _timerString;
  int get totalWorkTime => _totalWorkTime;
  int get totalBreakTime => _totalBreakTime;


  void getDefaultVal() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('minute')) {
      prefs.setString("minute", "45");
      prefs.setString('shortbreak', "15");
    } else {
      _defaultMinuteVal = int.parse(prefs.getString('minute'));
      _defaultShortbreak = int.parse(prefs.getString('shortbreak'));
      _minuteVal = _defaultMinuteVal.toInt();
      _shortbreak = _defaultShortbreak;
      setTimerString();
      notifyListeners();
    }
  }

  // setter
  void setTimerString() {
    if (_second < 10) {
      _timerString = "$_minuteVal:0$_second";
    } else {
      _timerString = "$_minuteVal:$_second";
    }
  }

  void setMinuteVal(int value) => _minuteVal = value;
  void resetSecond() => _second = 0;
  void changeDefaultShortBreak(int value) {
    _defaultShortbreak = value;
    notifyListeners();
  }

  void setDefaultShortBreak(int value) async {
    _defaultShortbreak = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("shortbreak", "$value");
    notifyListeners();
  }

  void setNoOfSessions(int value) {
    _noOfSessions = value;
    notifyListeners();
  }

  void setDefaultMinuteVal(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("minute", "$value");
    _defaultMinuteVal = value.toInt();
    if (_everySecond == null || !_everySecond.isActive) {
      reset();
    }
    notifyListeners();
  }

  void changeDefaultVal(double value) {
    _defaultMinuteVal = value.toInt();
    notifyListeners();
  }

  void toggleflag() {
    _startOrStop = !_startOrStop;
    notifyListeners(); // Remove comments only if it's used change from reset
  }

  void reset() {
    if (_workOrBreak) {
      _minuteVal = _defaultShortbreak.toInt();
    } else {
      _minuteVal = _defaultMinuteVal.toInt();
    }
    _workOrBreak = !_workOrBreak;
    _second = 00;
    stopTimer();
    _startOrStop = false;
    setTimerString();
    notifyListeners();
  }

  void subtract(Timer _everySecond, BuildContext context) {
    if (_second == 0) {
      _minuteVal = _minuteVal - 1;
      _second = 19; // 19 for debugging
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
      _everySecond = null;
    }
    _startOrStop = false;
    notifyListeners();
  }
}
