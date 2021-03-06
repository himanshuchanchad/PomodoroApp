import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/priority.dart';
import '../providers/task.dart';
import '../models/task_item.dart';

class AddTaskForm extends StatefulWidget {
  final TaskItem task;
  AddTaskForm({this.task});
  @override
  _AddTaskFormState createState() => _AddTaskFormState(task);
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _descriptionFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _form = GlobalKey<FormState>();
  double _noOfSession = 6;
  double _workTimer = 45;
  double _breakTimer = 15;
  Priority taskPriority = Priority.Low;
  TaskItem task;

  _AddTaskFormState(TaskItem task) {
    if (task != null) {
      _noOfSession = task.noOfSessions.toDouble();
      _workTimer = task.minuteWorkTimer.toDouble();
      _breakTimer = task.minuteBreakTimer.toDouble();
      taskPriority = task.priority;
      _titleController.text = task.title;
      _descriptionController.text = task.shortDescription;
    }
    this.task = task;
  }
  @override
  void initState() {
    final taskProvider = Provider.of<Task>(context, listen: false);
    _workTimer = taskProvider.defaultMinuteWorkTimer;
    _breakTimer = taskProvider.defaultMinuteBreakTimer;
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    if (task != null) {
      // update the task
      task.title = _titleController.text;
      task.shortDescription = _descriptionController.text;
      task.noOfSessions = _noOfSession.toInt();
      task.minuteBreakTimer = _breakTimer.toInt();
      task.minuteWorkTimer = _workTimer.toInt();
      task.priority = taskPriority;
      Provider.of<Task>(context, listen: false).updateTask(task);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    } else {
      try {
        Provider.of<Task>(context, listen: false).addTask(
            _titleController.text,
            _descriptionController.text,
            _noOfSession.toInt(),
            _workTimer.toInt(),
            _breakTimer.toInt(),
            taskPriority);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An error occured"),
            content: Text("Error occured"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Okay"),
              )
            ],
          ),
        );
        return;
      }
    Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        actions: <Widget>[
          FlatButton(
              onPressed: _saveForm,
              child: const Text(
                "SAVE",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top:10),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title",),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                minLines: 2,
                decoration: InputDecoration(labelText: "Description"),
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) {
                  Focus.of(context).unfocus();
                },
              ),
              ListTile(
                title: Text("No of Sessions"),
                contentPadding: EdgeInsets.all(10),
                subtitle: Slider(
                  activeColor: Colors.red,
                  inactiveColor: Colors.blue,
                  value: _noOfSession,
                  min: 1,
                  divisions: 7,
                  max: 8,
                  label: "${_noOfSession.toInt()}",
                  onChanged: (value) {
                    setState(() {
                      _noOfSession = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Work(minutes)"),
                subtitle: Slider(
                  value: _workTimer,
                  min: 15,
                  max: 59,
                  divisions: 44,
                  label: "${_workTimer.toInt()}",
                  onChanged: (value) {
                    setState(() {
                      _workTimer = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Break(minutes)"),
                subtitle: Slider(
                  value: _breakTimer,
                  min: 5,
                  max: 20,
                  divisions: 15,
                  label: "${_breakTimer.toInt()}",
                  onChanged: (value) {
                    setState(() {
                      _breakTimer = value;
                    });
                  },
                ),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Priority",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          "Low",
                          style: TextStyle(
                            color: taskPriority == Priority.Low
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        color: taskPriority == Priority.Low
                            ? Colors.green
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            taskPriority = Priority.Low;
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          "Medium",
                          style: TextStyle(
                            color: taskPriority == Priority.Medium
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        color: taskPriority == Priority.Medium
                            ? Colors.yellow[900]
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            taskPriority = Priority.Medium;
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          "High",
                          style: TextStyle(
                            color: taskPriority == Priority.High
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        color: taskPriority == Priority.High
                            ? Colors.red
                            : Colors.white,
                        onPressed: () {
                          setState(() {
                            taskPriority = Priority.High;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
