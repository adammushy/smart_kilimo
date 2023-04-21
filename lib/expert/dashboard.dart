import 'dart:convert';
import 'dart:io';

import 'package:agric/api.dart';
import 'package:agric/widgets/authenticationScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:agric/expert/dashboard.dart';
import 'package:agric/farmer/profileScreen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? regionValue;
  String? districtValue;
  String? categoryValue;
  String? wardValue;
  String? statusValue;
  String? contentvalue;

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  var userData;
  late int tabIndex;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  // TextEditingController retailPriceController = TextEditingController();
  // TextEditingController wholesalePriceController = TextEditingController();

  @override
  void initState() {
    checkLoginStatus();
    _getUserInfo();

    tabIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkLoginStatus() async {
    print("object");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(sharedPreferences.getString("token"));
    if (sharedPreferences.getString("token") == null) {
      // Navigator.of(context).pushReplacementNamed(RouteGenerator.login);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AgricExpertLoginScreen()));
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

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          imagefiles = pickedfiles;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
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
                                builder: (context) =>
                                    AgricExpertLoginScreen()));
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

  _add_Asset_Dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add New Content'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            labelText: 'Name'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 5,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            labelText: 'Description'),
                      ),
                    ),
                    Container(
                      child: FutureBuilder<List<Region_Items>>(
                        future: fetchRegionData(context),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: DropdownButton<String>(
                                hint: Text('Select Region'),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                value: regionValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    regionValue = newValue!;
                                  });
                                },
                                items: data.map((valueItem) {
                                  return DropdownMenuItem<String>(
                                    value: valueItem.id,
                                    child: Text(valueItem.name.toString()),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),

                    Container(
                      child: FutureBuilder<List<District_Items>>(
                        future: fetchDistrictData(context),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!;
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: DropdownButton<String>(
                                hint: Text('Select District'),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                value: districtValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    districtValue = newValue!;
                                  });
                                },
                                items: data.map((valueItem) {
                                  return DropdownMenuItem<String>(
                                    value: valueItem.id,
                                    child: Text(valueItem.name.toString()),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),

// *********************************DISTRICT VALUE*****************************************
                    // Container(
                    //     child: FutureBuilder<List<District_Items>>(
                    //   future: fetchDistrictData(context),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       var data = snapshot.data!;
                    //       return Container(
                    //         padding: EdgeInsets.only(
                    //             left: 10.0, right: 10.0, top: 3, bottom: 3),
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.grey),
                    //             borderRadius: BorderRadius.circular(12)),
                    //         child: DropdownButton<String>(
                    //           hint: Text('Select District'),
                    //           dropdownColor: Colors.white,
                    //           icon: Icon(Icons.arrow_drop_down),
                    //           iconSize: 36,
                    //           isExpanded: true,
                    //           underline: SizedBox(),
                    //           style:
                    //               TextStyle(color: Colors.black, fontSize: 15),
                    //           value: districtValue,
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               districtValue = newValue!;
                    //             });
                    //           },
                    //           items: data.map((valueItem) {
                    //             return DropdownMenuItem<String>(
                    //               value: valueItem.id,
                    //               child: Text(valueItem.name.toString()),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       );
                    //     } else {
                    //       return const CircularProgressIndicator();
                    //     }
                    //   },
                    // )),
//***********************************WARD DATA******** */******************** */
                    // Container(
                    //     child: FutureBuilder<List<Ward_Items>>(
                    //   future: fetchWardData(context),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       var data = snapshot.data!;
                    //       return Container(
                    //         padding: EdgeInsets.only(
                    //             left: 10.0, right: 10.0, top: 3, bottom: 3),
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.grey),
                    //             borderRadius: BorderRadius.circular(12)),
                    //         child: DropdownButton<String>(
                    //           hint: Text('Select Ward'),
                    //           dropdownColor: Colors.white,
                    //           icon: Icon(Icons.arrow_drop_down),
                    //           iconSize: 36,
                    //           isExpanded: true,
                    //           underline: SizedBox(),
                    //           style:
                    //               TextStyle(color: Colors.black, fontSize: 15),
                    //           value: wardValue,
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               wardValue = newValue!;
                    //             });
                    //           },
                    //           items: data.map((valueItem) {
                    //             return DropdownMenuItem<String>(
                    //               value: valueItem.id,
                    //               child: Text(valueItem.name.toString()),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       );
                    //     } else {
                    //       return const CircularProgressIndicator();
                    //     }
                    //   },
                    // )),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //   child: TextFormField(
                    //     controller: streetController,
                    //     style: TextStyle(fontSize: 15),
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(12)),
                    //         ),
                    //         labelText: 'Street'),
                    //   ),
                    // ),

                    MaterialButton(
                      elevation: 0,
                      color: Color.fromARGB(255, 25, 141, 2),
                      height: 50,
                      minWidth: 500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        //  _edit_Store_API();
                        // _addProduct_API();
                        // Navigator.pop(context);
                        openImages();
                      },
                      child: Text(
                        'Upload Images',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Divider(),

                    imagefiles != null
                        ? Wrap(
                            children: imagefiles!.map((imageone) {
                              return Container(
                                  child: Card(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(File(imageone.path)),
                                ),
                              ));
                            }).toList(),
                          )
                        : Container(),

                    Container(
                      // padding: const EdgeInsets.all(0.0),
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButton<String>(
                        value: contentvalue,
                        //elevation: 5,
                        // style: TextStyle(color: Colors.black),

                        hint: Text('Select Content Category'),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black, fontSize: 15),

                        items: <String>[
                          'crop',
                          'soil',
                          'disease',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),

                        onChanged: (String? value) {
                          print(value);
                          // var v = '0';
                          // if (value == 'Revenue') {
                          //   v = '1';
                          // }
                          setState(() {
                            contentvalue = value;
                            // _visible_tag = v;
                          });
                        },
                      ),
                    ),
// *************************************PRICE DATA***********************************
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //   child: TextFormField(
                    //     controller: priceController,
                    //     style: TextStyle(fontSize: 15),
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(12)),
                    //         ),
                    //         labelText: 'Amount'),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                    //   child: TextFormField(
                    //     controller: wholesalePriceController,
                    //     style: TextStyle(fontSize: 15),
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.all(Radius.circular(12)),
                    //         ),
                    //         labelText: 'Wholesale Price'),
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 70,
                    //       width: 70,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(
                    //           8,
                    //         ),
                    //         color: AppColor.kBlue,
                    //       ),
                    //       child: Center(
                    //         child: SvgPicture.asset(
                    //           'assets/images/image_placeholder.svg',
                    //           width: 32,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Text(
                    //       'No Cover Image Selected',
                    //       overflow: TextOverflow.ellipsis,
                    //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),

                    MaterialButton(
                      elevation: 0,
                      color: Color.fromARGB(255, 25, 141, 2),
                      height: 50,
                      minWidth: 500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        //  _edit_Store_API();
                        _addContent_API();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Upload',
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

  _addContent_API() async {
    print('*********** Add Assets function *********');
    print(userData.toString());

    // List<MultipartFile> newList = [];

    // for (var img in imagefiles!) {
    //   if (img != "") {
    //     var multipartFile = await MultipartFile.fromPath(
    //       'Photos',
    //       File(img).path,
    //       filename: img.split('/').last,
    //     );
    //     newList.add(multipartFile);
    //   }
    // }
    // request.files.addAll(newList);

    List<Map> myimg = [];
    for (var img in imagefiles!) {
      Map<String, String> imgList = {"image": img.path};
      myimg.add(imgList);
    }
// ******** DATA.OF THE CONTENT TO BE POSTED....****************************************************
    //*****POSTING********************** */
    var data = {
      'user_id': userData['id'].toString(),
      'name': nameController.text,
      'description': descriptionController.text,
      // 'region': regionValue,
      'wilaya_id': districtValue,
      'content_category': contentvalue,
      'created_by': userData['username'].toString(),

      // 'ward_id': wardValue,

      // 'status': chosenStatus,
      'images': myimg,
    };

    print("i am trying to post-------------");
    print(data);
    print(imagefiles![1].path);

    if (data['content_category'] == "crop") {
      var res =
          await CallApi().posData(data, 'main/product/createPost', context);
      // var res = await CallApi().posData(data, 'create_asset', context);
      // var body = json.decode(res.body);
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString("token", body['token']);
      // localStorage.setString("user", json.encode(body['user']));
      // print("---------the body cones--------");
      // print(body);
      if (res == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      } else {
        var body = json.decode(res!.body);
        print(body);

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Data saved Successfully")));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SearchScreen()));

        } else if (res.statusCode == 400) {
        } else {}
      }
    } else if (data['content_category'] == "soil") {
      var res = await CallApi().posData(data, 'soil/createPost', context);
      // var res = await CallApi().posData(data, 'create_asset', context);
      if (res == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      } else {
        var body = json.decode(res!.body);
        print(body);

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Data saved Successfully")));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SearchScreen()));

        } else if (res.statusCode == 400) {
        } else {}
      }
    } else if (data['content_category'] == "disease") {
      var res = await CallApi().posData(data, 'desease/createPost', context);
      // var res = await CallApi().posData(data, 'create_asset', context);
      if (res == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      } else {
        var body = json.decode(res!.body);
        print(body);

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Data saved Successfully")));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SearchScreen()));

        } else if (res.statusCode == 400) {
        } else {}
      }
    }
  }

// ***********CATERFORY  FUTURE****************
  Future<List<Category_Items>> fetchCategoryData(context) async {
    print(" Inside Category function");

    var res = await CallApi().getData('all_category', context);

    // print(res);
    if (res != null) {
      // print(res.body);
      // var body = json.decode(res.body);

      var categoryJson = json.decode(res.body)["data"];

      print(categoryJson);

      List<Category_Items> _categoryItems = [];

      for (var f in categoryJson) {
        Category_Items category_items = Category_Items(
          f["id"].toString(),
          f["name"].toString(),
        );
        _categoryItems.add(category_items);
      }
      print(_categoryItems.length);

      return _categoryItems;
    } else {
      return [];
    }
  }

  Future<List<Region_Items>> fetchRegionData(context) async {
    print(" Inside District function");

    var res = await CallApi().getData('auth/mikoa', context);

    // print(res);
    if (res != null) {
      print(res.body);
      var body = json.decode(res.body);

      var regionJson = json.decode(res.body)["mikoa"];

      List<Region_Items> _regionItems = [];

      for (var f in regionJson) {
        Region_Items region_items = Region_Items(
          f["id"].toString(),
          f["name"].toString(),
        );
        _regionItems.add(region_items);
      }
      print(_regionItems.length);

      return _regionItems;
    } else {
      return [];
    }
  }

  Future<List<District_Items>> fetchDistrictData(context) async {
    print(" Inside District function");

    var res = await CallApi()
        .getData('auth/wilaya/' + regionValue.toString(), context);

    // print(res);
    if (res != null) {
      print(res.body);
      var body = json.decode(res.body);

      var districtJson = json.decode(res.body)["wilaya"];

      List<District_Items> _districtItems = [];

      for (var f in districtJson) {
        District_Items district_items = District_Items(
          f["id"].toString(),
          f["name"].toString(),
        );
        _districtItems.add(district_items);
      }
      print(_districtItems.length);

      return _districtItems;
    } else {
      return [];
    }
  }

  // Future<List<Ward_Items>> fetchWardData(context) async {
  //   print(" Inside Ward function");

  //   var res =
  //       await CallApi().getData('ward/' + discrictValue.toString(), context);

  //   print(res);

  //   if (res != null) {
  //     print(res.body);
  //     var body = json.decode(res.body);

  //     var wardJson = json.decode(res.body)["data"];

  //     List<Ward_Items> _wardItems = [];

  //     for (var f in wardJson) {
  //       Ward_Items ward_items = Ward_Items(
  //         f["id"].toString(),
  //         f["name"].toString(),
  //       );
  //       _wardItems.add(ward_items);
  //     }
  //     print(_wardItems.length);

  //     return _wardItems;
  //   } else {
  //     return [];
  //   }
  // }
// ***************ASSET ITEMS*******************
  Future<List<Assets_Items>> fetchAssetsData(context) async {
    print(" Inside Assets function");

    var res = await CallApi()
        .getData('my_asset/' + userData['id'].toString(), context);

    // print(res);
    if (res != null) {
      // print(res.body);
      // var body = json.decode(res.body);

      var assetsJson = json.decode(res.body)["data"];

      print(assetsJson);

      List<Assets_Items> _assetsItems = [];

      for (var f in assetsJson) {
        Assets_Items assets_items = Assets_Items(
            f["id"].toString(),
            f["name"].toString(),
            f["description"].toString(),
            f["district"].toString(),
            f["username"].toString(),
            f["category_id"].toString(),
            // f["ward_id"].toString(),

            f["images"]);
        _assetsItems.add(assets_items);
      }
      print(_assetsItems.length);

      return _assetsItems;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70.0,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'Dashboard',
          ),
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width - 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dashboard'),
                    IconButton(
                      onPressed: () {
                        _logout_Dialog(context);
                      },
                      icon: const Image(
                        height: 24,
                        image: AssetImage("assets/logo2.png"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
      body: SafeArea(
        child: adminAssetsComponent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          _add_Asset_Dialog(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  adminAssetsComponent() {
    return FutureBuilder<List<Assets_Items>>(
      future: fetchAssetsData(context),
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
                                      child: Image.asset(
                                          'assets/images/product_0.png'),
                                    )),
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

                                        // Text(
                                        //     snapshot.data![index].quantity
                                        //         .toString(),
                                        //     style: TextStyle(
                                        //         color: Colors.grey[500])),
                                      ]),
                                )
                              ]),
                            ),

                            InkWell(
                              onTap: () async {},
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withAlpha(20)),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                    ),
                                  )),
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
                      ],
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SingleProductScreen(
                    //

                    //             )));
                  },
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
// *****contents below here come from packageS and manual*****

class Category_Items {
  final String? id, name;

  Category_Items(this.id, this.name);
}

class Region_Items {
  final String? id, name;

  Region_Items(this.id, this.name);
}

class District_Items {
  final String? id, name;

  District_Items(this.id, this.name);
}

// class Ward_Items {
//   final String? id, name;

//   Ward_Items(this.id, this.name);
// }

class Assets_Items {
  String? images;
  final String? id, name, description, district, username, category_id;

  Assets_Items(this.id, this.name, this.description, this.district,
      this.username, this.images, this.category_id);
}
