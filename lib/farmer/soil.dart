import 'package:agric/farmer/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:agric/farmer/singlePageScreen.dart';
import 'package:agric/widgets/theme.dart';
import 'package:agric/api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:agric/widgets/authenticationScreen.dart';
import 'package:flutter/widgets.dart';

class SoilScreen extends StatefulWidget {
    // List<Map<String, String>>? images;
  final String name;

  SoilScreen(
    this.name,
  );
  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
  var userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: jobComponent(),
        // child: Stack(children: [
        //   Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        //         child: PhysicalModel(
        //           borderRadius: BorderRadius.circular(25),
        //           color: Colors.white,
        //           elevation: 5.0,
        //           shadowColor: Colors.green,
        //           child: TextField(
        //             decoration: InputDecoration(
        //               fillColor: AppColors.white,
        //               filled: true,
        //               contentPadding:
        //                   const EdgeInsets.only(left: 40, right: 50),
        //               enabledBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //                 borderSide: const BorderSide(color: AppColors.white),
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(30),
        //                 borderSide: const BorderSide(color: AppColors.white),
        //               ),
        //               prefixIcon: const Icon(
        //                 Icons.search,
        //                 color: Colors.black,
        //               ),
        //               hintText: 'Search',
        //               hintStyle: const TextStyle(
        //                 color: AppColors.secondary,
        //                 fontSize: 14.0,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: SingleChildScrollView(
        //           padding:
        //               const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               // Text(
        //               //   'BataVibe',
        //               //   style: TextStyle(
        //               //     fontFamily: "RobotoBold",
        //               //     color: Colors.black,
        //               //     fontSize: 30,
        //               //     fontWeight: FontWeight.bold),
        //               //   ),

        //               SizedBox(
        //                 height: 30,
        //               ),
        //               jobComponent(),
        //               // SizedBox(
        //               //   height: 30,
        //               // ),
        //               // jobComponent(),

        //               // makeItem(name: "Statistics", image: 'assets/statistics.png', date: 11, month: "SEP", time: "18:00", location: "Kigamboni"),
        //               // SizedBox(height: 20,),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ]),
      ),
    );
  }

  Future<List<Crop_Items>> fetchCropsData(context) async {
    print(" Inside Assets function");

    var res = await CallApi()
        .getData('soilview/' + userData['id'].toString(), context);

    // print(res);
    if (res != null) {
      // print(res.body);
      // var body = json.decode(res.body);

      var assetsJson = json.decode(res.body)["data"];

      print(assetsJson);

      List<Crop_Items> _cropItems = [];

      for (var f in assetsJson) {
        Crop_Items crop_items = Crop_Items(
            f["id"].toString(),
            f["name"].toString(),
            f["description"].toString(),
            f["district"].toString(),
            f["username"].toString(),
            // f["category_id"].toString(),
            // f["ward_id"].toString(),

            f["images"]);
        _cropItems.add(crop_items);
      }
      print(_cropItems.length);

      return _cropItems;
    } else {
      return [];
    }
  }

  jobComponent() {
    return FutureBuilder<List<Crop_Items>>(
      future: fetchCropsData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              //itemCount: ProductModel.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(children: [
                                Container(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      // child: Image.asset(snapshot.data![index].product_image.toString()),

                                      // remove image after creating upload backend image to the server
                                       child:Image(
                            image: NetworkImage(
                              CallApi.image_crop +
                                  snapshot.data![index].images![0]['image']
                                      .toString(),
                            ),
                            fit: BoxFit.cover),
                                        // Image.asset(
                                      //     'assets/images/product_0.png'),
                                    ),
                                    ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            snapshot.data![index].name
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            snapshot.data![index].name
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey[500])),
                                      ]),
                                )
                              ]),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     // setState(() {
                            //     //   job.isMyFav = !job.isMyFav;
                            //     // });
                            //   },
                            //   child: AnimatedContainer(
                            //       height: 35,
                            //       padding: EdgeInsets.all(5),
                            //       duration: Duration(milliseconds: 300),
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(12),
                            //           border: Border.all(
                            //             color: job.isMyFav
                            //                 ? Colors.red.shade100
                            //                 : Colors.grey.shade300,
                            //           )),
                            //--------el mastra codes adamprosper99@gmail.com---------
                            //       child: Center(
                            //           child: job.isMyFav
                            //               ? Icon(
                            //                   Icons.favorite,
                            //                   color: Colors.red,
                            //                 )
                            //               : Icon(
                            //                   Icons.favorite_outline,
                            //                   color: Colors.grey.shade600,
                            //                 ))),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade200),
                                    child: Text(
                                      snapshot.data![index].description
                                          .toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey.withAlpha(20)),
                                      child: Text(
                                        snapshot.data![index].username
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      )),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(//*****************EDIT SCREEN********
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             EditProductScreen()));
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.withAlpha(20)),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  snapshot.data![index].id,
                                  snapshot.data![index].name,
                                  snapshot.data![index].description,
                                  // snapshot.data![index].district,
                                  // snapshot.data![index].product_code,
                                  // snapshot.data![index].images,
                      CallApi.image_soil + snapshot.data![index].images![0]['image']!,


                                  widget.name,
                                  // snapshot.data![index].buying_price,
                                  // snapshot.data![index].retail_price,
                                  // snapshot.data![index].wholesale_price,
                                  // snapshot.data![index].supplier,
                                  // snapshot.data![index].e_commerce_status,.
                                )));
                  },
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // return Container(
    //   padding: EdgeInsets.all(10),
    //   margin: EdgeInsets.only(bottom: 15),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20),
    //       color: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 0,
    //           blurRadius: 2,
    //           offset: Offset(0, 1),
    //         ),
    //       ]),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: Row(children: [
    //               Container(
    //                   width: 60,
    //                   height: 60,
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(20),
    //                     child: Image.asset(job.companyLogo),
    //                   )),
    //               SizedBox(width: 10),
    //               Flexible(
    //                 child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(job.title,
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontSize: 15,
    //                               fontWeight: FontWeight.w500)),
    //                       SizedBox(
    //                         height: 5,
    //                       ),
    //                       Text(job.address,
    //                           style: TextStyle(color: Colors.grey[500])),
    //                     ]),
    //               )
    //             ]),
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 job.isMyFav = !job.isMyFav;
    //               });
    //             },
    //             child: AnimatedContainer(
    //                 height: 35,
    //                 padding: EdgeInsets.all(5),
    //                 duration: Duration(milliseconds: 300),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(12),
    //                     border: Border.all(
    //                       color: job.isMyFav
    //                           ? Colors.red.shade100
    //                           : Colors.grey.shade300,
    //                     )),
    //                 child: Center(
    //                     child: job.isMyFav
    //                         ? Icon(
    //                             Icons.favorite,
    //                             color: Colors.red,
    //                           )
    //                         : Icon(
    //                             Icons.favorite_outline,
    //                             color: Colors.grey.shade600,
    //                           ))),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 Container(
    //                   padding:
    //                       EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(12),
    //                       color: Colors.grey.shade200),
    //                   child: Text(
    //                     job.type,
    //                     style: TextStyle(color: Colors.black),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 Container(
    //                   padding:
    //                       EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(12),
    //                       color: Color(
    //                               int.parse("0xff${job.experienceLevelColor}"))
    //                           .withAlpha(20)),
    //                   child: Text(
    //                     job.experienceLevel,
    //                     style: TextStyle(
    //                         color: Color(
    //                             int.parse("0xff${job.experienceLevelColor}"))),
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Text(
    //               job.timeAgo,
    //               style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class Crop_Items {
  List<Map<String, String>> images;
  final String? id, name, description, district, username;

  Crop_Items(this.id, this.name, this.description, this.district, this.username,
      this.images);
}
