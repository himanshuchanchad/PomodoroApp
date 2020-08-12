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

  void _onPressed(CurrentTimer currentTimer, BuildContext context) {
    if (!currentTimer.flag) {
      currentTimer.startTimer(context);
    } else {
      currentTimer.stopTimer();
    }
  }

  // void _reset(CurrentTimer currentTimer) {
  //   currentTimer.reset();
  // }

  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 204, 43, 94),
            Color.fromARGB(255, 117, 58, 136),
          ],
        ),
        // color: Colors.black,
      ),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PomodoroCircularSlider(),
            Expanded(
                child: Column(
              children: [
                Container(
                  child: Text(
                    currentTimer.workorBreakStatus ? "Working" : "Break",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Container(
                  child: Text(currentTimer.title,style: TextStyle(color: Colors.white,fontSize: 40)),
                ),
                Container(
                  child: Text(
                    "${currentTimer.totalWorkTime}",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  height: 60,
                  child: RaisedButton(
                    color: Colors.blue[900],
                    child: currentTimer.flag
                        ? Icon(
                            Icons.pause,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                    shape: CircleBorder(),
                    onPressed: () => _onPressed(currentTimer, context),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 40, left: 30),
                //   height: 60,
                //   child: RaisedButton(
                //     child: Icon(
                //       Icons.settings_backup_restore,
                //       color: Colors.white,
                //       size: 40,
                //     ),
                //     onPressed: () => _reset(currentTimer),
                //     color: Colors.blue[900],
                //     shape: CircleBorder(),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
