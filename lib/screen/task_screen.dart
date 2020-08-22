import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/task_tile.dart';
import '../widgets/add_task_form.dart';
import '../providers/task.dart';

class TaskScreen extends StatelessWidget {
  void _addTask(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return AddTaskForm(task:null);
      },
      fullscreenDialog: true,
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
                  ),
                  
                  ),
            )
          ],
        )
      ],
    );
  }
}
