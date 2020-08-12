import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/timer.dart';
import 'providers/task.dart';
import './screen/home_screen.dart';
import './screen/settings.dart';
import './screen/task_screeen.dart';

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

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;
  int minuteVal;
  PageController _pageController = PageController(initialPage: 1);
  var screen = [TaskScreen(), HomeScreen(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
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
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.blue,
          splashColor: Colors.pink[200],
          accentColor: Colors.white,
          primaryTextTheme: TextTheme(
            headline6:
                TextStyle(color: Colors.white,),
              
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "Pomodoro",
              style: TextStyle(fontStyle: FontStyle.italic),
            )),
          ),
          // body: screen[_selectedIndex],
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
            selectedFontSize: 16.0,
            onTap: _onItemTapped,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.orange[400],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
