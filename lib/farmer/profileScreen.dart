import 'package:flutter/material.dart';

import '../widgets/profile_listtile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final minValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Container(
          //   height: 210,
          //   width: double.infinity,
          //   color: Colors.black,
          //   child: Center(
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(top: 30.0),
          //           child: Container(
          //             height: 110,
          //             width: 110,
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 image: DecorationImage(
          //                     image: AssetImage("assets/profile.jpg"),
          //                     fit: BoxFit.cover)),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(top: 15.0),
          //           child: SizedBox(
          //             height: 32,
          //             width: 140,
          //             child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                     primary: Colors.green,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(25),
          //                     )),
          //                 onPressed: () {},
          //                 child: Text(
          //                   "Edit Profile",
          //                   style: TextStyle(color: Colors.white),
          //                 )),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 14),
            child: Container(
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: minValue * 6.5,
                    backgroundImage: AssetImage("assets/ngao.png"),
                  ),
                  SizedBox(
                    width: minValue * 1.5,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Username",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "Status",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 14),
            child: Text(
              "Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // CustomListTile(
          //   "Edit Profile",
          //   Icons.edit_outlined,
          //   Icons.keyboard_arrow_right_outlined,
            
          // ),

          // SwitchListTile(
          //   value: _darkMode,
          //   title: Text(
          //     'Transfer files over Wi-Fi',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //     ),
          ////----ELMASTRA CODES adamprosper99@gmail.com----    

          //   ),
          //   secondary: Padding(
          //     padding: const EdgeInsets.all(9.0),
          //     child: Icon(Icons.wifi),
          //   ),
          //   onChanged: (newValue) {
          //     setState(() {
          //       _darkMode = newValue;
          //     });
          //   },
          //   // visualDensity: VisualDensity.adaptivePlatformDensity,
          //   // switchType: SwitchType.material,
          //   activeColor: Colors.indigo,
          // ),
          // CustomListTile(
          //   "Setting",
          //   Icons.settings,
          //   Icons.keyboard_arrow_right_outlined,
          // ),

          // CustomListTile(
          //   "Favorite list",
          //   Icons.favorite_outline,
          //   Icons.keyboard_arrow_right_outlined,
          // ),
          CustomListTile(
            "Help",
            Icons.space_bar_rounded,
            Icons.keyboard_arrow_right_outlined,
          ),
          CustomListTile(
            "About us",
            Icons.person_outline,
            Icons.keyboard_arrow_right_outlined,
          ),

          ListTile(
            title: Text(
              ("Sign out"),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: (Icon(
                Icons.logout,
                size: 25,
              )),
            ),
            tileColor: Colors.grey.shade100,
            subtitle: Text("Registered to example@gmail.com"),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20, top: 15, bottom: 14),
          //   child: Text(
          //     "Support",
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),

          // CustomListTile(
          //   "Contact us",
          //   Icons.message,
          //   Icons.keyboard_arrow_right_outlined,
          // ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
