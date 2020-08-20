import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';
import '../widgets/pomodoro_slider_widget.dart';
import '../utils/priority.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onPressed(CurrentTimer currentTimer, BuildContext context) {
    if (!currentTimer.flag) {
      currentTimer.startTimer(context);
    } else {
      currentTimer.stopTimer();
    }
  }

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
            Card(
              margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
              color: Colors.black,
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            getPriorityColor(currentTimer.priority),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(
                              currentTimer.title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            currentTimer.shortDescription == ""?
                            Text(
                              currentTimer.shortDescription,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ):null,

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
                              "${currentTimer.currentSession}/${currentTimer.noOfSessions}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              //TODO currentSession
                              "${currentTimer.totalWorkTime}/${currentTimer.minuteWorkTimer * currentTimer.noOfSessions}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            PomodoroCircularSlider(),
            Expanded(
              child: Column(
                          children: [
                            Container(
                              child: Text(
                                currentTimer.workorBreakStatus
                                    ? "Working"
                                    : "Break",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                            ),
                          ],
                        ),
            ),
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
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                    shape: const CircleBorder(),
                    onPressed: () => _onPressed(currentTimer, context),
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
