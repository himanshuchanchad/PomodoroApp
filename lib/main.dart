import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/timer.dart';
import 'providers/task.dart';
import './screen/home_screen.dart';
import './screen/settings.dart';
import 'screen/task_screen.dart';
import './utils/theme_data.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int _selectedIndex = 1;
  int minuteVal;
  PageController _pageController = PageController(initialPage: 1);
  var screen = [TaskScreen(), HomeScreen(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentTimer()),
        ChangeNotifierProvider(create: (_) => Task()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,//edit in util/theme_data.dart
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Pomodoro"),
            ),
          ),
          body: PageView(
            controller: _pageController,
            children: screen,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.content_paste),
                title: Text('Task'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}
