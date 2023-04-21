import 'package:agric/farmer/homescreen.dart';
import 'package:agric/widgets/authenticationScreen.dart';
import 'package:flutter/material.dart';
import 'package:agric/farmer/homescreen.dart';
import 'package:agric/farmer/welcome.dart';
import 'package:agric/expert/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      Welcome(),
      //  HomeScreen(),
    );
  }
}
