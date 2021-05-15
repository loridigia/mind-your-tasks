import 'package:flutter/material.dart';
import 'package:mind_your_tasks/screens/home_page.dart';
import 'package:mind_your_tasks/screens/welcomePage.dart';
import 'package:mind_your_tasks/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kBlue, // navigation bar color
    statusBarColor: Colors.blue, // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: LightColors.kDarkBlue,
              displayColor: LightColors.kDarkBlue,
              fontFamily: 'Poppins'
            ),
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
