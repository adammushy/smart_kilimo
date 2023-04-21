import 'package:agric/farmer/crop.dart';
import 'package:agric/farmer/soil.dart';
import 'dart:convert';
import 'package:agric/api.dart';

import 'package:agric/farmer/disease.dart';
import 'package:agric/farmer/singlePageScreen.dart';
import 'package:agric/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agric/widgets/authenticationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  var userData;

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
      Uri.parse(
          'http://192.168.43.68:5000/auth/info/'), //***I CHANGED IT TO THE IP THAT  FROM http://192.17.20.159:8000/auth/info/*****
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

  _logout_Dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Log Out'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        'Are you sure you want to logout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: Colors.black,
                      height: 50,
                      minWidth: 500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () async {
                        //  _edit_Store_API();
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.clear();

                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen()));
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              Center(
                child: InkWell(
                  child: Image.asset(
                    'assets/logo1.png',
                    width: 100,
                    height: 100,
                  ),
                  onTap: () {
                    _logout_Dialog(context);
                  },
                ),
              ),
              Divider(
                height: 2,
                color: Colors.grey[800],
              ),
              // **********SEARCH CONTENT WILL BE HERE******************
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              //   child: PhysicalModel(
              //     borderRadius: BorderRadius.circular(25),
              //     color: Colors.white,
              //     elevation: 5.0,
              //     shadowColor: Colors.green,
              //     child: TextField(
              //       decoration: InputDecoration(
              //         fillColor: AppColors.white,
              //         filled: true,
              //         contentPadding:
              //             const EdgeInsets.only(left: 40, right: 50),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: const BorderSide(color: AppColors.white),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: const BorderSide(color: AppColors.white),
              //         ),
              //         prefixIcon: const Icon(
              //           Icons.search,
              //           color: Colors.black,
              //         ),
              //         hintText: 'Search',
              //         hintStyle: const TextStyle(
              //           color: AppColors.secondary,
              //           fontSize: 14.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   'BataVibe',
                      //   style: TextStyle(
                      //     fontFamily: "RobotoBold",
                      //     color: Colors.black,
          ////----ELMASTRA CODES adamprosper99@gmail.com----    

                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold),
                      //   ),

                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      makeItem(
                        name: "Disease",
                        image: 'assets/weather.png',
                        date: 1,
                        month: "FEB",
                        time: "06:00",
                        location: "City Mall",
                        index: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      makeItem(
                        name: "Crop",
                        image: 'assets/prediction.png',
                        date: 26,
                        month: "APR",
                        time: "20:00",
                        location: "Kijitonyama",
                        index: 2,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      makeItem(
                        name: "Soil",
                        image: 'assets/soil.png',
                        date: 17,
                        month: "JAN",
                        time: "12:00",
                        location: "Tabata Kimanga",
                        index: 0,
                      ),
                      // makeItem(name: "Statistics", image: 'assets/statistics.png', date: 11, month: "SEP", time: "18:00", location: "Kigamboni"),
                      // SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget makeItem({name, image, date, month, time, location, index}) {
    return Row(
      children: <Widget>[
        // Container(
        //   width: 50,
        //   height: 200,
        //   margin: EdgeInsets.only(right: 20),
        //   child: Column(
        //     children: <Widget>[
        //       Text(
        //         date.toString(),
        //         style: TextStyle(
        //             color: Colors.blue,
        //             fontSize: 25,
        //             fontWeight: FontWeight.bold),
        //       ),
        //       Text(
        //         month,
        //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //       )
        //     ],
        //   ),
        // ),

        Expanded(
          child: GestureDetector(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.1),
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.access_time,
                    //       color: Colors.white,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(

                    //           -------   ----el mastra code 255719401594--------------
                    //                    //       time,
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),

                    //     Icon(
                    //       Icons.calendar_today,
                    //       color: Colors.white,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       date.toString(),
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //      SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       month,
                    //       style: TextStyle(color: Colors.white),
                    //     ),

                    //   ],
                    // ),

                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.white,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       location,
                    //       style: TextStyle(color: Colors.white),
                    //     ),

                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            onTap: () {
              print(index);

              if (name == "Soil") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SoilScreen(name)));
              } else if (name == "Disease") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiseaseScreen(name)));
              } else if (name == "Crop") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CropScreen(name)));
              }
            },
          ),
        ),
      ],
    );
  }
}
