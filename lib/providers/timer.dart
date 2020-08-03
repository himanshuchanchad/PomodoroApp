import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTimer with ChangeNotifier {
  int _minuteVal = 45;
  int _second = 00;
  bool _flag = true;
  double _defaultMinuteVal = 45.0;
  Timer _everySecond;

  CurrentTimer() {
    getDefaultVal();
  }

  double getDefaultMinuteVal() => _defaultMinuteVal;
  int getMinuteVal() => _minuteVal;
  int getSecond() => _second;
  bool getflag() => _flag;
  
  String getTimerString() {
    if (_second < 10) {
      return "$_minuteVal:0$_second";
    }
    return "$_minuteVal:$_second";
  }

  void toggleflag() {
    _flag = !_flag;
    notifyListeners();
  }

  void resetSecond() => _second = 0;
  void setMinuteVal(int value) => _minuteVal = value;

  void reset() {
    _minuteVal = _defaultMinuteVal.toInt();
    _second = 00;
    notifyListeners();
  }

  void subtract(Timer _everySecond) {
    if (_second == 0) {
      _minuteVal = _minuteVal - 1;
      _second = 59;
      if (_minuteVal < 0) {
        _everySecond.cancel();
        //TODO need to add break logic
      }
    } else {
      _second = _second - 1;
    }
    notifyListeners();
  }

  void startTimer() {
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      subtract(_everySecond);
      notifyListeners();
    });
  }

  void stopTimer() {
    _everySecond.cancel();
  }

  void getDefaultVal() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('minute')) {
      prefs.setString("minute", "45");
    } else {
      _defaultMinuteVal = double.parse(prefs.getString('minute'));
      notifyListeners();
    }
  }

  void changeDefaultVal(double value) {
    _defaultMinuteVal = value;
    notifyListeners();
  }

  void setDefaultVal(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("minute", "$value");
    _defaultMinuteVal = value;
    if (_everySecond == null || !_everySecond.isActive) {
      reset();
    }
    notifyListeners();
  }
}
