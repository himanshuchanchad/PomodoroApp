import 'package:PomodoroApp/widgets/timerWidget.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
    var children2 = <Widget>[
      SizedBox(height: 50,),
      // Container(
      //   height: 300,
      //   width: double.infinity,
      //   child: SleekCircularSlider(
      //     // innerWidget: TimerWidget(currentTimer.getTimerString()) as Widget,
      //     appearance: CircularSliderAppearance(
      //         customWidths: CustomSliderWidths(progressBarWidth: 10),
      //         ),
      //     min: 00,
      //     max: 59,
      //     initialValue: 45,
      //   ),
      // ),
      TimerWidget(currentTimer.getTimerString()),
      Expanded(child: Container()),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
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
              onPressed: () => _onPressed(currentTimer),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
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
      SizedBox(
        height: 40,
      )
    ];
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
          children: children2,
        ),
      ),
    );
  }
}
