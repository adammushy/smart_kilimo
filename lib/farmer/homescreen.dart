import 'dart:convert';

import 'package:agric/api.dart';
import 'package:agric/farmer/communityScreen.dart';
import 'package:agric/farmer/profileScreen.dart';
import 'package:agric/farmer/serviceScreen.dart';
import 'package:agric/widgets/authenticationScreen.dart';
import 'package:agric/expert/dashboard.dart';
import 'package:agric/expert/post.dart';
import 'package:agric/expert/dashboard.dart';
import 'package:agric/farmer/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData;

  int page = 0; // This will store the index of the page we're on
  final _controller = new PageController(initialPage: 0);
  List<Widget> widgets = [
    // Welcome(),
    // list of pages I'll be scrolling through
    ServicesScreen(),
    // CommunityScreen(),
    // DashboardScreen(),
    // ProfileScreen(),
  ];

  @override
  void initState() {
    
    checkLoginStatus();
    _getUserInfo();
    get_If_user_is_Farmer_or_Expert();

    //listenNotifications();
    super.initState();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  get_If_user_is_Farmer_or_Expert() async {
    print("inside user info");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
      // Uri.parse('http://192.168.43.68:5000/auth/info/'),
      Uri.parse('http://192.168.43.68:8000/auth/info/'),


      // Uri.parse('http://192.168.43.68:8000/auth/info/'),
      // Uri.parse('http://127.0.0.1:8000/auth/info/'),

      //***I CHANGED IT TO THE IP THAT  ELMASTRA CODES FROM http://192.17.20.159:8000/auth/info/*****
      headers: {
        'Authorization': 'Bearer ' + sharedPreferences.getString("token")!,
      },
    );
    var body = json.decode(response.body);

    print(body);
    // var res = await CallApi().getData('info/');
    // var body = json.decode(res.body);

    // print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            children: widgets, // set 'children' to the list of pages
            controller: _controller, // set this to the controller
            onPageChanged: (num) {
              // what will happen when you switch
              setState(() {
                // Update state
                page = num; // Set the page we're on to the num argument
              });
            }),
        floatingActionButton: get_If_user_is_Farmer_or_Expert() == 'farmer'
            ? FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.agriculture),
                onPressed: () {
                  // get_If_user_is_Farmer_or_Expert();
                })
            : Container());
  }
}
