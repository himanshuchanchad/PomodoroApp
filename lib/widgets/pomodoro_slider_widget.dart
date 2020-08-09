import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:provider/provider.dart';

import './timer_widget.dart';
import '../providers/timer.dart';

class PomodoroCircularSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
    return   Container(
      padding: const EdgeInsets.only(top: 50),
      height: 300,
      width:  double.infinity,
      child:  SleekCircularSlider(
        innerWidget: (double value) {
          return TimerWidget();
        },

        appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 10),
          customColors:CustomSliderColors(
            progressBarColors: <Color>[Colors.white,Colors.green[300]],
            hideShadow: true,
            trackColor: Colors.amber[300]
            // progressBarColor: Colors.white,
          ) ,
        ),
        min: 00,
        max: currentTimer.defaultMinuteVal.toDouble(),
        initialValue: currentTimer.minuteVal.toDouble(),
      ),
    );
  }
}
