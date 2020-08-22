import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';
import '../providers/task.dart';
import '../widgets/pomodoro_slider_widget.dart';
import '../utils/priority.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with WidgetsBindingObserver{

  void _onPressed(CurrentTimer currentTimer, BuildContext context) {
    if (!currentTimer.flag) {
      currentTimer.startTimer(context);
    } else {
      currentTimer.stopTimer();
    }
  }
   @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        Provider.of<Task>(context, listen: false).saveTask();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
              margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text(
                                currentTimer.title,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 40),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Text(
                                currentTimer.shortDescription,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
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
                              "${currentTimer.currentSession}/${currentTimer.noOfSessions}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
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
                      currentTimer.workorBreakStatus ? "Working" : "Break",
                      style: TextStyle(color: Colors.white, fontSize: 40),
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
