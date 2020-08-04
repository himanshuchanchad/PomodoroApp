import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  String timeString;
  TimerWidget(this.timeString);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.transparent,
      child: Text(
        timeString,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
