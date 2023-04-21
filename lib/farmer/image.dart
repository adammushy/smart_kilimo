import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dalali_app/consts/houseobj.dart';
import 'package:flutter/material.dart';
import 'package:agric/api.dart';

class ImageShow extends StatefulWidget {
  List<Map<String, String>> imageList;
  String imgUrl;
  ImageShow({Key? key, required this.imageList, required this.imgUrl})
      : super(key: key);

  @override
  _ImageShowState createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.white,
        leadingWidth: 85,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ImageIcon(
              AssetImage("assets/close.png"),
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 18),
            child: Text(
              (imageIndex + 1).toString() +
                  " / " +
                  widget.imageList.length.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: CarouselSlider.builder(
          itemCount: widget.imageList.length,
          itemBuilder: (context, index, realIndex) {
            final image = widget.imageList[index]['image'];

            return buildImage(image!, index);
          },
          options: CarouselOptions(
              enlargeCenterPage: true,
              height: 300,
              initialPage: 0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  imageIndex = index;
                });
              }),
        ),
      ),
    );
  }

  Widget buildImage(String imagepath, int index) => Container(
        child: Image(image: NetworkImage(widget.imgUrl + imagepath)),
      );
}
