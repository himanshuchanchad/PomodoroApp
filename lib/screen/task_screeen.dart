import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/task_tile.dart';
import '../providers/Task.dart';

class TaskScreen extends StatelessWidget {
  void _addTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.indigo[300],
              child: Center(
                child: FlatButton(
                  color: Colors.amber[700],
                  child: Text("delete"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<Task>(context);
    final task = taskProvider.tasks;
    return Column(
      children: <Widget>[
        Expanded(
          child: taskProvider.getLength() == 0
              ? Center(
                  child: Text("NO TASK"),
                )
              : ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (ctx, i) => TaskTile(
                    id: task.keys.toList()[i],
                    minuteBreakTimer: task.values.toList()[i].minuteBreakTimer,
                    minuteWorkTimer: task.values.toList()[i].minuteWorkTimer,
                    noOfSessions: task.values.toList()[i].noOfSessions,
                    priority: task.values.toList()[i].priority,
                    shortDescription: task.values.toList()[i].shortDescription,
                    title: task.values.toList()[i].title,
                  ),
                ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 50,
              width: 60,
              margin: EdgeInsets.only(bottom: 20),
              child: FlatButton(
                  shape: CircleBorder(),
                  color: Colors.blue[900],
                  onPressed: () => _addTask(context),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            )
          ],
        )
      ],
    );
  }
}
