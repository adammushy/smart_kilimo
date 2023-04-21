import 'package:flutter/material.dart';
import 'package:agric/farmer/singlePageScreen.dart';
import 'package:agric/widgets/theme.dart';
import 'package:agric/api.dart';
import 'package:agric/farmer/image.dart';
import 'package:agric/farmer/crop.dart';
import 'package:agric/farmer/soil.dart';
import 'package:agric/farmer/disease.dart';
import 'package:agric/widgets/sizes.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:agric/widgets/authenticationScreen.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  String? images;
  final String? id, name, description, catname;

  // category_id,
  // ward_id,
  // street,
  // status,
  // price,
  // dalali;

  DetailPage(
    this.id,
    this.name,
    this.description,
    this.images,
    this.catname,
    // this.
    // username,
    // this.category_id,
    // this.ward_id,
    // this.street,
    // this. status,
    // this.price,
    // this. images,
    // this.dalali,
  );

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool fav = false;

  String myUrl(String name) {
    if (name == 'Crop') {
      return CallApi.image_crop;
    } else if (name == 'Disease') {
      return CallApi.image_disease;
    } else {
      return CallApi.image_soil;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '',
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 223, 221, 221)),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:20.0,),
                      child: InkWell(
                        // directed to the widget of images *********************************************
                    
                        // onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //     //   builder: (context) => ImageShow(
                        //     //     imageList: widget.images!,
                        //     //     imgUrl: myUrl(widget.catname!),
                        //     //   ),
                        //     // )),
                        child: Image(
                          width: 1000,
                          image: NetworkImage(
                              widget.images.toString()),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   left: 30,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Container(
                    //       margin: const EdgeInsets.only(bottom: 6.0),
                    //       height: 32,
                    //       width: 32,
                    //       decoration: BoxDecoration(
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: Offset(0.0, 2.0), //(x,y)
                    //             blurRadius: 2.0,
                    //           ),
                    //         ],
                    //         // shape: BoxShape.circle,
                    //         // color: Colors.white,
                    //       ),
                    //       // child: Padding(
                    //       //   padding: const EdgeInsets.all(2.0),
                    //       //   child: ImageIcon(
                    //       //     AssetImage("assets/backicon2.png"),
                    //       //     size: 32,
                    //       //   ),
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 30,
                    //   right: 30,
                    //   child: InkWell(
                    //     onTap: () {
                    //       // setState(() {
                    //       //   if (!widget.selectedHouse.faved) {
                    //       //     context
                    //       //         .read<FavoritesChangeNotifier>()
                    //       //         .addItem(widget.selectedHouse);
                    //       //   } else {
                    //       //     context
                    //       //         .read<FavoritesChangeNotifier>()
                    //       //         .deleteItem(widget.selectedHouse);
                    //         // }
                    //       // });
                    //       // setState(() {
                    //       //   widget.selectedHouse.faved =
                    //       //       !widget.selectedHouse.faved;
                    //       // });
                    //     },
                    //     child: Container(
                    //       margin: const EdgeInsets.only(bottom: 6.0),
                    //       height: 32,
                    //       width: 32,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: Offset(0.0, 2.0), //(x,y)
                    //             blurRadius: 2.0,
                    //           ),
                    //         ],
                    //       ),
                    //       child: !widget.selectedHouse.faved
                    //           ? Padding(
                    //               padding: const EdgeInsets.all(2.0),
                    //               child: ImageIcon(
                    //                 AssetImage(
                    //                   "lib/assets/images/favicon3.png",
                    //                 ),
                    //                 color: Colors.black,
                    //               ),
                    //             )
                    //           : Padding(
                    //               padding: const EdgeInsets.all(2.0),
                    //               child: ImageIcon(
                    //                 AssetImage(
                    //                     "lib/assets/images/favicon4.png"),
                    //                 color: Color(0xffFB6161),
                    //               ),
                    //             ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.name!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       widget.!,
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w300, fontSize: 16),
                    //     ),
                    //     Text(
                    //       'Tshs ' + widget.price!,
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w600, fontSize: 16),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,top: 0.0, bottom: 0.0),
                      child: Row(
                        children: [
                          // Container(
                          //   height: 48,
                          //   width: 48,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //   ),
                          //   child: Image(
                          //       image: AssetImage(
                          //           widget.selectedHouse.owner.imagepath)),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 12.0),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         '',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 16),
                          //       ),
                          //       SizedBox(
                          //         height: 4,
                          //       ),
                          //       // Text(
                          //       //   "Expert",
                          //       //   style: TextStyle(color: Color(0xffFB6161)),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         children: [
                    //           Container(
                    //             height: 72,
                    //             width: 64,
                    //             margin: const EdgeInsets.only(bottom: 6.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey,
                    //                   offset: Offset(0.0, 2.0),
                    //                   blurRadius: 2.0,
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(16.0),
                    //               child: ImageIcon(
                    //                 AssetImage(
                    //                     "lib/assets/images/bedroomicon2.png"),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 8,
                    //           ),
                    //           Text(
                    //             widget.selectedHouse.bedroom.toString(),
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "Bedrooms",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           Container(
                    //             height: 72,
                    //             width: 64,
                    //             margin: const EdgeInsets.only(bottom: 6.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey,
                    //                   offset: Offset(0.0, 2.0),
                    //                   blurRadius: 2.0,
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(16.0),
                    //               child: ImageIcon(AssetImage(
                    //                   "assets/livingroomicon2.png")),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 8,
                    //           ),
                    //           Text(
                    //             widget.selectedHouse.livingroom.toString(),
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "Livingroom",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           Container(
                    //             height: 72,
                    //             width: 64,
                    //             margin: const EdgeInsets.only(bottom: 6.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey,
                    //                   offset: Offset(0.0, 2.0),
                    //                   blurRadius: 2.0,
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(16.0),
                    //               child: ImageIcon(AssetImage(
                    //                   "assets/kitchenicon2.png")),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 8,
                    //           ),
                    //           Text(
                    //             widget.selectedHouse.kitchen.toString(),
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "Kitchen",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           Container(
                    //             height: 72,
                    //             width: 64,
                    //             margin: const EdgeInsets.only(bottom: 6.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: Colors.white,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey,
                    //                   offset: Offset(0.0, 2.0),
                    //                   blurRadius: 2.0,
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(16.0),
                    //               child: ImageIcon(AssetImage(
                    //                   "assets/bathroomicon2.png")),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 8,
                    //           ),
                    //           Text(
                    //             widget.selectedHouse.bathroom.toString(),
                    //             style: TextStyle(
                    //                 fontSize: 12, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "Bathrooms",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text("Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.description!,
                          style: TextStyle(fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // Text("Contact Dalali",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w500, fontSize: 18),
                        //         ),
                        SizedBox(
                          height: 4,
                        ),

                        // Text(
                        //   widget.username!,
                        //   textAlign: TextAlign.start,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 24,
                        //   ),
                        // ),
                        // Tooltip(
                        //   message: 'double tap to open',
                        //   preferBelow: false,
                        //   child: InkWell(
                        //     onDoubleTap: () {
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //       builder: (context) => GoogleMaps(),
                        //       //     ));
                        //     },
                        //     child: Container(
                        //       height: 200,
                        //       width: MediaQuery.of(context).size.width - 60,
                        //       decoration: BoxDecoration(color: Colors.green),
                        //       child: Image(
                        //           image: AssetImage(
                        //               "lib/assets/images/googlemaps.png"),
                        //           fit: BoxFit.cover),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          height: 80,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // bottomNavigationBar: SizedBox(
        //   height: 73,
        //   child: BottomAppBar(
        //     color: Colors.white,
        //     elevation: 0.0,
        //     child: FittedBox(
        //       fit: BoxFit.none,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: InkWell(
        //           onTap: () {},
        //           child: Container(
        //             alignment: Alignment.center,
        //             margin: const EdgeInsets.only(bottom: 6.0),
        //             height: 46,
        //             width: 186,
        //             decoration: BoxDecoration(
        //               color: Color(0xffFB6161),
        //               borderRadius: BorderRadius.circular(10),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.grey,
        //                   offset: Offset(0.0, 1.0), //(x,y)
        //                   blurRadius: 6.0,
        //                 ),
        //               ],
        //             ),
        //             child: Text(
        //               "Call",
        //               style: TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w600,
        //                   color: Colors.white),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      
      ),
    );
  }
}
