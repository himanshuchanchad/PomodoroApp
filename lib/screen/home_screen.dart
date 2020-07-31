import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/set_pomodoro_timer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer _everySecond;
  int currentTimer = 45;
  int currentSecond = 59;
  var timerstring = "45:00";
  void _getTimer(int value) {
    currentTimer = value - 1;
    currentSecond = 59;
    timerstring = "${currentTimer - 1}:59";
  }

  void _showBottomModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SetPomodoroTimer(_getTimer);
      },
    );
  }

  void _onPressed() {
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (currentSecond == 0) {
          currentSecond = 59;
          if (currentTimer <0) {
            _everySecond.cancel();
          }
          currentTimer = currentTimer - 1;
        } else {
          currentSecond = currentSecond - 1;
        }
        timerstring = "${currentTimer}:${currentSecond}";
      });
    });
  }

  void _reset() {
    _everySecond.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text(
                  timerstring,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "START",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _onPressed,
            ),
            FlatButton(
              child: Text("Reset"),
              onPressed: _reset,
            ),
            FlatButton(
              child: Icon(Icons.add),
              onPressed: () => _showBottomModal(context),
            )
          ],
        ),
      ),
    );
  }
}
