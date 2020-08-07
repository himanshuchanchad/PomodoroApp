import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Priority { High, Low, Medium }

class TaskItem {
  int id;
  String title;
  String shortDescription;
  int noOfSessions;
  int minuteWorkTimer = 45;
  int minuteBreakTimer = 15;

  int currentSession = 0;
  int currentTotalTime = 0;
  DateTime date = DateTime.now();
  Priority priority = Priority.Low;
  bool _isDone = false;

  TaskItem({
    this.title,
    this.shortDescription,
    this.noOfSessions,
    this.minuteWorkTimer,
    this.minuteBreakTimer,
    this.priority,
  });

  bool getTaskStatus() => _isDone;
  void toggleTaskStatus() {
    _isDone = !_isDone;
  }
}

class Task with ChangeNotifier {
  int _uniqueID = 0;
  Map<int, TaskItem> _tasks = {};

  Map<int, TaskItem> get tasks {
    if (_tasks.isEmpty) {
      return null;
    }
    return {..._tasks};
  }
  int getLength() =>_tasks.isEmpty ? 0:_tasks.length  ;
  // Task() {
  //    getTaskFromSharedPreferences();
  // }
  void getTaskFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tasks')) {
      // TODO need to add logic here to fetch data from shared preference
    }
  }

  void addTask(String title, String shortDescription, int noOfSessions,
      int minuteWorkTimer, int minuteBreakTimer, Priority priority) {
    _tasks.putIfAbsent(
        _uniqueID,
        () => TaskItem(
              title: title,
              shortDescription: shortDescription,
              noOfSessions: noOfSessions,
              minuteWorkTimer: minuteWorkTimer,
              minuteBreakTimer: minuteBreakTimer,
              priority: priority,
            ));
    notifyListeners();
  }

  void removeTask(int id) {
    if (!_tasks.containsKey(id)) {
      return;
    }
    _tasks.remove(id);
    notifyListeners();
  }
}
