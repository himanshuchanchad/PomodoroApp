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
        totalBreakTime = json['totalBreakTime'],
        priority = getPriorityEnum(json['priority']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'shortDescription': shortDescription,
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

  bool get taskStatus => _isDone;
  void toggleTaskStatus() {
    _isDone = !_isDone;
  }
}