import 'dart:convert';

import 'package:agric/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SinglePageScreen extends StatefulWidget {
  final String image, name, time, month, location;
  final int date;

  const SinglePageScreen({Key? key, required this.image, required this.name, required this.time, required this.date, required this .month, required this.location}) : super(key: key);


  
  @override
  State<SinglePageScreen> createState() => _SinglePageScreenState();
}

class _SinglePageScreenState extends State<SinglePageScreen> {

  final List<String> _list = [
    'Arusha',
    'Dar es Salaam',
    'Dodoma',
    'Geita',
    'Iringa',
    'Kagera',
    'Katavi',
    'Kigoma',
    'Kilimanjaro',
    'Lindi',
    'Manyara',
    'Mara',
    'Mbeya',
    'Morogoro',
    'Mtwara',
    'Mwanza',
    'Njombe',
    'Pwani',
    'Rukwa',
    'Ruvuma',
    'Shinyanga',
    'Simiyu',
    'Singida',
    'Songwe',
    'Tabora',
    'Tanga',
  ];

  

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = true;
  bool _startDirection = false;
  bool _horizontalScroll = true;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;
  double _fontSize = 14;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];


  @override
  void initState() {
    super.initState();
    

    _items = _list.toList();
  }

  late List _items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Row(
      children: <Widget>[
        // Expanded(
        //   child: Row(
        //     children: [
        //       SizedBox(height: 30,),
        //               makeItem(name: "Soil",image: 'assets/soil.png'),
        //               SizedBox(height: 20,),
        //               makeItem(name: "Weather", image: 'assets/weather.png'),
        //               SizedBox(height: 20,),
        //               makeItem(name: "Prediction", image: 'assets/prediction.png'),
        //               SizedBox(height: 20,),
        //               makeItem(name: "Statistics", image: 'assets/statistics.png'),
        //               SizedBox(height: 20,),
                      
        //     ],

        //   )),
        
        Expanded(
          child: Container(
            // height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(widget.image), fit: BoxFit.cover)),
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
                    widget.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                   SizedBox(
                        height: 10,
                      ),

                      // _tags1,

                      
                     
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                      Row(
                        children: <Widget>[
                          makeItem(name: "Soil",image: 'assets/soil.png'),
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.location,
                            style: TextStyle(color: Colors.white),
                          ),
                       
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
      ),

    );
  }

  Widget get _tags1 {
    return Tags(
      // key: _tagStateKey,
      // symmetry: _symmetry,
      // columns: _column,
      // horizontalScroll: _horizontalScroll,
      // //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
      // heightHorizontalScroll: 60 * (_fontSize / 14),
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          pressEnabled: true,
          activeColor: Colors.blueGrey[600],
          singleItem: _singleItem,
          splashColor: Colors.green,
          combine: ItemTagsCombine.withTextBefore,
          // image: index > 0 && index < 5
          //     ? ItemTagsImage(
          //         //image: AssetImage("img/p$index.jpg"),
          //         child: Image.network(
          //         "http://www.clipartpanda.com/clipart_images/user-66327738/download",
          //         width: 16 * _fontSize / 14,
          //         height: 16 * _fontSize / 14,
          //       ))
          //     : (1 == 1
          //         ? ItemTagsImage(
          //             image: NetworkImage(
          //                 "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
          //           )
          //         : null),
          // icon: (item == '0' || item == '1' || item == '2')
          //     ? ItemTagsIcon(
          ////----ELMASTRA CODES adamprosper99@gmail.com----    
          //     icon: _icon[int.parse(item)],
          //       )
          //     : null,
          // removeButton: _removeButton
          //     ? ItemTagsRemoveButton(
          //         onRemoved: () {
          //           setState(() {
          //             _items.removeAt(index);
          //           });
          //           return true;
          //         },
          //       )
          //     : null,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
          textStyle: TextStyle(
            fontSize: _fontSize,
          ),
          onPressed: (item) {
            // createAlertDialog_Feedback(context);
            showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(item.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: textWhiteGrey,
                //     borderRadius: BorderRadius.circular(14.0),
                //   ),
                //   child: TextFormField(
                //     // controller: userNumberController,
                //     keyboardType: TextInputType.phone,
                //     decoration: InputDecoration(
                //       hintText: 'Class Code',
                //       hintStyle: heading6.copyWith(color: textGrey),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                    borderRadius: BorderRadius.circular(14.0),
                    elevation: 0,
                    child: Container(
                      height: 46,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // _checkifNumberExist();
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => AdditionalInfoScreen()));
                          },
                          borderRadius: BorderRadius.circular(14.0),
                          child: Center(
                            child: Text(
                              'Tuma',
                              style: heading6.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )),
              
                    Material(
                    borderRadius: BorderRadius.circular(14.0),
                    elevation: 0,
                    child: Container(
                      height: 46,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // _checkifNumberExist();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => VerifyScreen()));

                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                              Colors.transparent,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(25)
                              // ),
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  decoration:const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:BorderRadius.only(
                                      topLeft:Radius.circular(20),
                                      topRight:Radius.circular(20),
                                        // bottomLeft: Radius.circular(20),
                                        // bottomRight: Radius.circular(20),
                                    )),
                                    child: ListView(
                                      children: [
                                         Padding(
                                        padding:EdgeInsets.only(
                                          left: 20,top: 15,bottom: 14),
                                        child: Text(item.title,
                                          style: TextStyle(fontSize: 20,fontWeight:
                                           FontWeight.bold),
                                        ),
                                      ),
                                        
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                });
                          },
                          borderRadius: BorderRadius.circular(14.0),
                          child: Center(
                            child: Text(
                              'Fuatilia',
                              style: heading6.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ))
              
                  ]
                )
                
              ],
            ),
          );
        });

            print(item);
          },
        );
      },
    );
  }


  Widget makeItem({name, image}) {
    return Row(
      children: <Widget>[
       
        
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 100,
              // width: 50,
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
                   
                  
                  ],
                ),
              ),
            ),
          onTap: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (_) => SinglePageScreen(
            //             image: image,
            //             name: name,
                        
            //           )));
          },
          ),
        ),
      ],
    );
  
  }

}