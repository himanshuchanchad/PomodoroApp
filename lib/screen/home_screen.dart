import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:provider/provider.dart';

import '../providers/timer.dart';
import '../widgets/pomodoro_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Timer _everySecond;

  void _onPressed(CurrentTimer currentTimer,BuildContext context) {
    if (currentTimer.getflag()) {
      currentTimer.startTimer(context);
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
    
    //     var columnChildren = <Widget>[
    //       ;

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 0, 124, 232),
            Color.fromARGB(255, 167, 183, 196),
          ],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PomodoroCircularSlider(),
            Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  height: 60,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: currentTimer.getflag()
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          )
                        : Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                    shape: CircleBorder(),
                    onPressed: () => _onPressed(currentTimer,context),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40, left: 30),
                  height: 60,
                  child: RaisedButton(
                    child: Icon(
                      Icons.settings_backup_restore,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () => _reset(currentTimer),
                    color: Colors.blue,
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
