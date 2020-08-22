import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/priority.dart';
import '../models/task_item.dart';

class Task with ChangeNotifier {
  int _uniqueID = 1;
  double _defaultMinuteWorkTimer = 45;
  double _defaultMinuteBreakTimer = 15;
  Map<int, TaskItem> _tasks = {};

  double get defaultMinuteWorkTimer => _defaultMinuteWorkTimer;
  double get defaultMinuteBreakTimer => _defaultMinuteBreakTimer;
  TaskItem task(int id) {
    return _tasks[id];
  }

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

  void updateTask(TaskItem taskItem) async {
    _tasks.update(taskItem.id, (value) => taskItem);
    final prefs = await SharedPreferences.getInstance();
    final extractedTask =
        jsonDecode(prefs.getString("tasks")) as Map<String, dynamic>;
    extractedTask.update(
        taskItem.id.toString(), (value) => jsonEncode(taskItem.toJson()));
    prefs.setString("tasks", jsonEncode(extractedTask));
    notifyListeners();
  }

  void saveTask() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> savedTask = {};
    _tasks.forEach((key, value) {
      savedTask.putIfAbsent(key.toString(), () => jsonEncode(value.toJson()));
    });
    prefs.setString("tasks", jsonEncode(savedTask));
  }

  void removeTask(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedTask =
        jsonDecode(prefs.getString("tasks")) as Map<String, dynamic>;
    extractedTask.remove(id.toString());
    prefs.setString("tasks", jsonEncode(extractedTask));
    _tasks.remove(id);
    notifyListeners();
  }
}
