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
  int defaultTimerValue = 45;
  int currentSecond = 00;
  var timerstring = "45:00";
  bool flag = true;
  void _getTimer(int value) {
    setState(() {
      defaultTimerValue = value;
      if (flag) {
        currentTimer = defaultTimerValue;
        currentSecond = 00;
        timerstring = "$currentTimer:00";
      }
    });
  }

  void _showBottomModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SetPomodoroTimer(_getTimer);
      },
    );
  }

  void subtract() {
    if (currentSecond == 0) {
      currentTimer = currentTimer - 1;
      currentSecond = 10;
      if (currentTimer < 0) {
        _everySecond.cancel();
        flag = true;
        //TODO need to add break logic
      }
    } else {
      currentSecond = currentSecond - 1;
    }
  }

  void _onPressed() {
    if (this.flag) {
      _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          this.subtract();
          timerstring = "$currentTimer:$currentSecond";
        });
      });
      setState(() {
        flag = false;
      });
    } else {
      setState(() {
        flag = true;
        _everySecond.cancel();
      });
    }
  }

  void _reset() {
    _everySecond.cancel();
    setState(() {
      flag = true;
      currentTimer = defaultTimerValue;
      timerstring = "$currentTimer:00";
    });
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
                flag ? "START" : "PAUSE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _onPressed,
            ),
            FlatButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _reset,
              color: Colors.blue,
            ),
            FlatButton(
              shape: new CircleBorder(),
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () => _showBottomModal(context),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
