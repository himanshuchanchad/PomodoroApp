import 'package:PomodoroApp/models/task_item.dart';
import 'package:PomodoroApp/utils/priority.dart';
import 'package:flutter/material.dart';

import './add_task_form.dart';

class TaskDetails extends StatelessWidget {
  final TaskItem task;
  TaskDetails({this.task});
  void editTask(BuildContext context, TaskItem task) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (context) {
        return AddTaskForm(task: task);
      },
      fullscreenDialog: true,
    ));
  }

  Container modifiedContainer(String heading, String content) => Container(
        margin: EdgeInsets.only(top: 10,bottom: 10),
        child: Row(
          children: [
            Flexible(
              child: Text(
                heading,
                style: textStyle,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Flexible(
              child: Text(
                content,
                style: textStyle,
              ),
            ),
          ],
        ),
      );

  final textStyle = TextStyle(color: Colors.black, fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Detail"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => editTask(context, task),
              child: const Text(
                "EDIT",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Container(
        color: Colors.transparent,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
  
            Container(
            width: double.infinity,  
            alignment: Alignment.center,
            child: Text(task.title,style: TextStyle(color:Colors.white,fontSize: 40)),
            color: getPriorityColor(task.priority),
            ),
            Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,  
            alignment: Alignment.center,
            child: Text(task.shortDescription,
              overflow: TextOverflow.clip,
            style: TextStyle(color:Colors.black,fontSize: 20)),
            ),
            // modifiedContainer("", task.title),
            modifiedContainer("Sessions:     ", "${task.currentSession}/${task.noOfSessions}"),
            modifiedContainer("Total work : ", "${task.totalWorkTime}/${task.minuteWorkTimer*task.noOfSessions}"),
            modifiedContainer("Total Break : ", "${task.totalBreakTime}/${task.minuteBreakTimer*task.noOfSessions}"),
          ],
        ),
      ),
    );
  }
}
