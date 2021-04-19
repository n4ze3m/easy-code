import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class MyWeb extends StatelessWidget {
  const MyWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Code',
      initialRoute: '/',
      routes: {
        "/": (context) => HomeScreen(),
      },
    );
  }
}

// iframe ref: https://stackoverflow.com/questions/63407370/can-i-use-two-iframes-on-flutter-web
