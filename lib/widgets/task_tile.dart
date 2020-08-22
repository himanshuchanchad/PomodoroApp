import 'package:PomodoroApp/widgets/task_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/priority.dart';
import '../providers/task.dart';
import '../providers/timer.dart';
// import './add_task_form.dart';
import './task_details.dart';
import '../models/task_item.dart';

class TaskTile extends StatelessWidget {
  final int id;

  const TaskTile({
    this.id,
  });

  void loadTask(BuildContext context, TaskItem task) {
    // work here
    Provider.of<CurrentTimer>(context, listen: false).loadTask(task);
  }

  void updateTask(BuildContext context, TaskItem task) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        // return AddTaskForm(task:task);
        return TaskDetails(task: task);
      },
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<Task>(context);
    final task = taskList.task(id);
    return Container(
      child: Card(
        shadowColor: Colors.grey[400],
        color: Colors.black,
        elevation: 5,
        child: Dismissible(
          key: ValueKey(id),
          background: Container(
            color: Colors.red[700],
            child: Icon(Icons.delete),
          ),
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Are you sure ?'),
                      content: Text(
                          'Are you sure you want to remove the task from the list?'),
                      actions: [
                        FlatButton(
                          child: Text("No"),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () => Navigator.of(context).pop(true),
                        )
                      ],
                    ));
          },
          onDismissed: (direction) {
            Provider.of<Task>(context, listen: false).removeTask(id);
          },
          direction: DismissDirection.startToEnd,
          child: FlatButton(
            onPressed: () => updateTask(context, task),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    // TODO  a check box
                    CircleAvatar(
                      backgroundColor: getPriorityColor(task.priority),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Container(
                            width: 160,//temporary solution
                            child: Text(
                              task.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              task.shortDescription == null
                                  ? ""
                                  : task.shortDescription,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      disabledColor: Colors.red[700],
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: task.taskStatus == false
                          ? () => loadTask(context, task)
                          : null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
