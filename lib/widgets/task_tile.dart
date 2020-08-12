import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/priority.dart';
import '../providers/task.dart';
import '../providers/timer.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final int id;
  final String shortDescription;
  final int noOfSessions;
  final int minuteWorkTimer;
  final int minuteBreakTimer;

  final int currentSession;
  final int totalWorkTime ;
  final int totaBreakTime;
  final Priority priority;

  const TaskTile({
    this.title,
    this.id,
    this.shortDescription,
    this.noOfSessions,
    this.minuteWorkTimer,
    this.minuteBreakTimer,
    this.priority,
    this.currentSession,
    this.totalWorkTime,
    this.totaBreakTime,
  });

  Color getPriorityColor(Priority priority) {
    if (priority == Priority.Low) {
      return Colors.green;
    }
    if (priority == Priority.Medium) {
      return Colors.blue;
    }
    return Colors.red[900];
  }

  void loadTask(BuildContext context) {
    Provider.of<CurrentTimer>(context,listen: false).loadTask(
      id,
      title,
      shortDescription,
      minuteWorkTimer,
      minuteBreakTimer,
      noOfSessions,
      currentSession,
      totalWorkTime,
      totaBreakTime,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () =>loadTask(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO  a check box
                    CircleAvatar(
                      backgroundColor: getPriorityColor(priority),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          Text(
                            shortDescription == null ? "" : shortDescription,
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
                            "$currentSession/$noOfSessions",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            //TODO currentSession
                            "$totalWorkTime/${minuteWorkTimer * noOfSessions}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
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
