import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/priority.dart';
import '../providers/task.dart';
import '../providers/timer.dart';
import './add_task_form.dart';

class TaskTile extends StatelessWidget {
  final int id;

  const TaskTile({
    this.id,
  });

  void loadTask(BuildContext context, TaskItem task) {
    // work here
    Provider.of<CurrentTimer>(context, listen: false).loadTask(
      id,
      task.title,
      task.shortDescription,
      task.minuteWorkTimer,
      task.minuteBreakTimer,
      task.noOfSessions,
      task.currentSession,
      task.totalWorkTime,
      task.totalBreakTime,
      task.priority,
    );
  }
  void updateTask(BuildContext context,TaskItem task){
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return AddTaskForm(task:task);
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
            onPressed: () => updateTask(context, task),//update task
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // TODO  a check box
                    CircleAvatar(
                      backgroundColor: getPriorityColor(task.priority),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          Text(
                            task.shortDescription == null
                                ? ""
                                : task.shortDescription,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            //TODO currentSession
                            "${task.currentSession}/${task.noOfSessions}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            //TODO currentSession
                            "${task.totalWorkTime}/${task.minuteWorkTimer * task.noOfSessions}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      shape: CircleBorder(),
                      child: Icon(Icons.play_arrow,color: Colors.blue,),
                      onPressed: () => loadTask(context, task),
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
