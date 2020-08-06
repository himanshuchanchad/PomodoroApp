import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/play_audio.dart';
import '../widgets/music_dialog.dart';

class CurrentTimer with ChangeNotifier {
  int _minuteVal = 45;
  int _second = 0;
  double _defaultMinuteVal = 45.0;
  Timer _everySecond;
  int _defaultShortbreak = 15;
  int _shortbreak = 15;
  int _noOfSessions = 6;

  String _timerString = '';
  bool _showDialog = false;
  bool _startOrStop = true;
  bool _workOrBreak = true;
  PlayAudio _playAudio = PlayAudio();

  CurrentTimer() {
    getDefaultVal();
  }
  // getter
  double getDefaultMinuteVal() => _defaultMinuteVal;
  int getMinuteVal() => _minuteVal;
  int getSecond() => _second;
  int getShortBreak() => _shortbreak;
  int getDefaultShortBreak() => _defaultShortbreak;
  int getNoOfSessions() => _noOfSessions;
  bool getflag() => _startOrStop;
  bool getShowDialogStatus() => _showDialog;
  String getTimerString() => _timerString;

  void getDefaultVal() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('minute')) {
      prefs.setString("minute", "45");
      prefs.setString('shortbreak', "15");
    } else {
      _defaultMinuteVal = double.parse(prefs.getString('minute'));
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

  void setToggleDialogStatus() {
    _showDialog = !_showDialog;
    if (_showDialog) {
      _playAudio.play();
    } else {
      _playAudio.stop();
    }
    notifyListeners();
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
    // if (_everySecond == null || !_everySecond.isActive) {
    //   reset();
    // }
    notifyListeners();
  }

  void setNoOfSessions(int value) {
    _noOfSessions = value;
    notifyListeners();
  }

  void setDefaultMinuteVal(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("minute", "$value");
    _defaultMinuteVal = value;
    if (_everySecond == null || !_everySecond.isActive) {
      reset();
    }
    notifyListeners();
  }

  void changeDefaultVal(double value) {
    _defaultMinuteVal = value;
    notifyListeners();
  }

  void toggleflag() {
    _startOrStop = !_startOrStop;
    notifyListeners();
  }

  void reset() {
    _minuteVal = _defaultMinuteVal.toInt();
    _second = 00;
    setTimerString();
    notifyListeners();
  }

  void subtract(Timer _everySecond) {
    if (_second == 0) {
      _minuteVal = _minuteVal - 1;
      _second = 59;
      if (_minuteVal < 0) {
        _minuteVal = 0;
        _second = 0;
        _everySecond.cancel();
        //TODO need to add break logic
      }
    } else {
      _second = _second - 1;
    }
    setTimerString();
    notifyListeners();
  }

  void startTimer() {
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      subtract(_everySecond);
    });
  }

  void stopTimer() {
    _everySecond.cancel();
  }
}
