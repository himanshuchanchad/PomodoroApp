// import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/priority.dart';

class TaskItem {
  int id;
  String title;
  String shortDescription;
  int noOfSessions;
  int minuteWorkTimer = 45;
  int minuteBreakTimer = 15;

  int currentSession = 0;
  int totalWorkTime = 0;
  int totalBreakTime = 0;
  DateTime date = DateTime.now();
  Priority priority = Priority.Low;
  bool _isDone = false;

  TaskItem({
    this.id,
    this.title,
    this.shortDescription,
    this.noOfSessions,
    this.minuteWorkTimer,
    this.minuteBreakTimer,
    this.priority,
  });
  TaskItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        shortDescription = json['shortDescription'],
        noOfSessions = json['noOfSessions'],
        minuteWorkTimer = json['minuteWorkTimer'],
        minuteBreakTimer = json['minuteBreakTimer'],
        totalWorkTime = json['totalWorkTime'],
        totalBreakTime=json['totalBreakTime'],
        priority = getPriorityEnum(json['priority']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'shortDesrciption': shortDescription,
        "noOfSessions": noOfSessions,
        "minuteWorkTimer": minuteWorkTimer,
        "minuteBreakTimer": minuteBreakTimer,
        "currentSession": currentSession,
        "totalWorkTime": totalWorkTime,
        "totalBreakTime": totalBreakTime,
        "date": date.toIso8601String(),
        "priority": getPriorityString(priority),
        "_isDone": _isDone,
      };

  bool getTaskStatus() => _isDone;
  void toggleTaskStatus() {
    _isDone = !_isDone;
  }
}

class Task with ChangeNotifier {
  int _uniqueID = 1;
  double _defaultMinuteWorkTimer = 45;
  double _defaultMinuteBreakTimer = 15;

  double get defaultMinuteWorkTimer => _defaultMinuteWorkTimer;
  double get defaultMinuteBreakTimer => _defaultMinuteBreakTimer;

  void setDefaultMinuteWorkTimer(double value) async {
    _defaultMinuteWorkTimer = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("minute", "$value");
    notifyListeners();
  }

  void setDefaultMinuteBreakTimer(double value) async {
    _defaultMinuteBreakTimer = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("shortbreak", "$value");
    notifyListeners();
  }

  Map<int, TaskItem> _tasks = {};

  Map<int, TaskItem> get tasks {
    if (_tasks.isEmpty) {
      return null;
    }
    return {..._tasks};
  }

  int getLength() => _tasks.isEmpty ? 0 : _tasks.length;
  Task() {
    getTaskFromSharedPreferences();
  }
  void getTaskFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (prefs.containsKey('tasks')) {
      final extractedTask = jsonDecode(prefs.getString("tasks"));
      var maxone = 0;
      extractedTask.forEach((key, value) {
        if (int.parse(key) > maxone) {
          maxone = int.parse(key);
        }
        _tasks.putIfAbsent(
            int.parse(key), () => TaskItem.fromJson(jsonDecode(value)));
      });
      _uniqueID = maxone + 1;
      notifyListeners();
    }
    if (prefs.containsKey('minute') && prefs.containsKey('shortbreak')) {
      _defaultMinuteBreakTimer = double.parse(prefs.getString('shortbreak'));
      _defaultMinuteWorkTimer = double.parse(prefs.getString('minute'));
      notifyListeners();
    } else {
      prefs.setString('minute', '45');
      prefs.setString('shortbreak', '15');
    }
  }

  void addTask(String title, String shortDescription, int noOfSessions,
      int minuteWorkTimer, int minuteBreakTimer, Priority priority) async {
    final taskItem = TaskItem(
      id: _uniqueID,
      title: title,
      shortDescription: shortDescription,
      noOfSessions: noOfSessions,
      minuteWorkTimer: minuteWorkTimer,
      minuteBreakTimer: minuteBreakTimer,
      priority: priority,
    );
    _tasks.putIfAbsent(_uniqueID, () => taskItem);

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('tasks')) {
      Map<String, dynamic> tasks = {};
      tasks.putIfAbsent(
          _uniqueID.toString(), () => jsonEncode(taskItem.toJson()));
      prefs.setString("tasks", jsonEncode(tasks));
    } else {
      final extractedTask =
          jsonDecode(prefs.getString("tasks")) as Map<String, dynamic>;
      extractedTask.putIfAbsent(
          _uniqueID.toString(), () => jsonEncode(taskItem.toJson()));
      prefs.setString("tasks", jsonEncode(extractedTask));
    }
    _uniqueID++;
    notifyListeners();
  }

  void removeTask(int id) async {
    if (!_tasks.containsKey(id)) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final extractedTask =
        jsonDecode(prefs.getString("tasks")) as Map<String, dynamic>;
    extractedTask.remove(id);
    prefs.setString("tasks", jsonEncode(extractedTask));
    // TODO remove it from the shared preferences also
    _tasks.remove(id);
    notifyListeners();
  }
}
