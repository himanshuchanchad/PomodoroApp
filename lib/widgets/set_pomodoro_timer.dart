import 'package:flutter/material.dart';

class SetPomodoroTimer extends StatefulWidget {
  final Function setTimer;
  SetPomodoroTimer(this.setTimer);
  @override
  _SetPomodoroTimerState createState() => _SetPomodoroTimerState();
}

class _SetPomodoroTimerState extends State<SetPomodoroTimer> {
  final _timerController = TextEditingController();

  void _submitData() {
    final enteredTimer = int.parse(_timerController.text);
    if (enteredTimer <= 0) {
      return;
    }
    widget.setTimer(enteredTimer);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 2,
              controller: _timerController,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                hintText: "Time in minutes",
              ),
            ),
            RaisedButton(
              child: Text("SET"),
              color: null,
              textColor: null,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
