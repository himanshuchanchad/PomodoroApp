import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../providers/Task.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          subtitle: Text(shortDescription),
          trailing: Text(noOfSessions.toString()),
          
        )
        ),
      );
  }
}
