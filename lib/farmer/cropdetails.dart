// import 'package:agric/farmer/detailpage.dart';
// import 'package:flutter/material.dart';
// import 'package:agric/farmer/singlePageScreen.dart';
// import 'package:agric/widgets/theme.dart';
// import 'package:agric/api.dart';
// import 'package:agric/farmer/crop.dart';
// import 'dart:convert';
// // import 'package:agric/farmer/cropdetails.dart';
// import 'dart:io';
// import 'package:http/http.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:agric/widgets/authenticationScreen.dart';
// import 'package:flutter/widgets.dart';


// class DetailPage extends StatelessWidget {
//    List<Map<String, String>>? images;

//   final String? id, name, description, catname;

//   DetailPage(

//       this.id, this.name, this.description, this.images, this.catname);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 250,
//             width: double.infinity,
//             child: Image.network(
//               CallApi.image_crop + images[0]['image'].toString(),
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             name,
//             style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Category: $categoryName",
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
