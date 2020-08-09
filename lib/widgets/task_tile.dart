import 'package:flutter/material.dart';

import '../utils/priority.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final int id;
  final String shortDescription;
  final int noOfSessions;
  final int minuteWorkTimer;
  final int minuteBreakTimer;

  final int currentSession = 0;
  final int currentTotalTime = 0;
  final Priority priority;

  const TaskTile({
    this.title,
    this.id,
    this.shortDescription,
    this.noOfSessions,
    this.minuteWorkTimer,
    this.minuteBreakTimer,
    this.priority,
  });

  String getPriorityString(Priority priority) {
    if (priority == Priority.Low) {
      return "Low";
    }
    if (priority == Priority.Medium) {
      return "Medium";
    }
    return "High";
  }

  Color getPriorityColor(Priority priority) {
    if (priority == Priority.Low) {
      return Colors.white;
    }
    if (priority == Priority.Medium) {
      return Colors.green;
    }
    return Colors.red[900];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 5,
      child: FlatButton(
        onPressed: ()=>print("you clicked"),
        child: Column(
          children: <Widget>[
            Text(title),
            Text(shortDescription),
            Text(noOfSessions.toString()),
            Text(getPriorityString(priority)),
          ],
        ),
      ),
    ));
  }
}
