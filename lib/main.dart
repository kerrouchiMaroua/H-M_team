import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(PomodoroApp());
}

class PomodoroApp extends StatefulWidget {
  @override
  _PomodoroAppState createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  // Default theme mode is light
  ThemeMode _themeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Updated to bodyLarge
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Color(0xFF040D06),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Updated to bodyLarge
        ),
      ),
      themeMode: _themeMode, // Dynamically change theme mode
      home: PomodoroTimer(
        onToggleTheme: toggleThemeMode,
      ),
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const PomodoroTimer({required this.onToggleTheme});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const int focusDuration = 25 * 60; // 25 minutes
  static const int breakDuration = 5 * 60; // 5 minutes

  int remainingTime = focusDuration; // Default to focus session
  bool isRunning = false;
  bool isFocusMode = true;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            timer.cancel();
            isRunning = false;
            toggleMode();
          }
        });
      });
    }
  }

  void stopTimer() {
    if (isRunning) {
      setState(() {
        isRunning = false;
      });
      timer?.cancel();
    }
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
      remainingTime = isFocusMode ? focusDuration : breakDuration;
    });
  }

  void toggleMode() {
    setState(() {
      isFocusMode = !isFocusMode;
      remainingTime = isFocusMode ? focusDuration : breakDuration;
    });
  }

  String formatMinutes(int seconds) {
    int minutes = seconds ~/ 60;
    return '${minutes.toString().padLeft(2, '0')}';
  }

  String formatSeconds(int seconds) {
    int remainingSeconds = seconds % 60;
    return '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isFocusMode ? 'Focus Mode' : 'Break Time'),
        centerTitle: true,
        actions: [
          // Add theme toggle button
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clock UI
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatMinutes(remainingTime),
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatSeconds(remainingTime),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: stopTimer,
                  iconSize: 60,
                  icon: Image.asset(
                    'lib/assets/3points.png', // Ensure the image is correct
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: startTimer,
                  iconSize: 40,
                  icon: Image.asset(
                    'lib/assets/play.png', // Ensure the image is correct
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: resetTimer,
                  iconSize: 30,
                  icon: Image.asset(
                    'lib/assets/next.png', // Ensure the image is correct
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
