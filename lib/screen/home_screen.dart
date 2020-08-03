import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:provider/provider.dart';

import '../providers/timer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Timer _everySecond;

  void _onPressed(CurrentTimer currentTimer) {
    if (currentTimer.getflag()) {
      currentTimer.startTimer();
    } else {
      currentTimer.stopTimer();
    }
    currentTimer.toggleflag();
  }

  void _reset(CurrentTimer currentTimer) {
    try {
      currentTimer.stopTimer();
    } catch (e) {
      print("Nothing to worry about $e");
    }
    currentTimer.reset();
    if (!currentTimer.getflag()) {
      currentTimer.toggleflag();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
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
                  currentTimer.getTimerString(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                currentTimer.getflag() ? "START" : "PAUSE",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _onPressed(currentTimer),
            ),
            FlatButton(
              child: Text(
                "Reset",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _reset(currentTimer),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
