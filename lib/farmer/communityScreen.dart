// import 'package:flutter/material.dart';

// class CommunityScreen extends StatefulWidget {
//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: SafeArea(
//           child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               classesList(),
//               SizedBox(height: 20,),

//               classesList(),

//               SizedBox(
//                   height: 20,
//                 ),
//                 classesList(),

//                 SizedBox(
//                   height: 20,
//                 ),
//                 classesList(),
//             ],
//       ),
//           ),
//         )
//     )
    
    

//     );
//   }

//   Widget classesList (){
//     return Container(
//       // width: 270,
//       // height: 230,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x40000000),
//             spreadRadius: -4,
//             blurRadius: 25,
//             offset: Offset(0, 4), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     padding: EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.grey.withOpacity(0.1),
//                     ),
//                     child: Image.asset('assets/logo2.png', width: 100,),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Username or Company',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis),
//                   ),

              
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // setState(() {
//                   //   widget.job.isMark = !widget.job.isMark;
//                   //   // if(selected = true)
//                   //   //   selected=false;
//                   // });
//                 },
//                 child: Container(
//                   child: Icon(
//                     Icons.bookmark_outline_sharp,

//                       // widget.job.isMark == false
//                       //     ? Icons.bookmark_outline_sharp
//                       //     : Icons.bookmark,
//                       // color: widget.job.isMark == false
//                       //     ? Colors.grey
//                       //     : Theme.of(context).primaryColor
//                       )
//                           ,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(
//             height: 15,
//           ),

//           Text(
//             'Content',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 15,
//           ),

//             Container(
//               height: 200,
//               width: 400,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                       image: AssetImage('assets/logo2.png'), fit: BoxFit.cover)),
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: LinearGradient(colors: [
//                       Colors.black.withOpacity(.4),
//                       Colors.black.withOpacity(.1),
//                     ])),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
                    
                  
//                   ],
//                 ),
//               ),
//             ),
          
          
//         ],
//       ),
//     );
  
//   }

// }