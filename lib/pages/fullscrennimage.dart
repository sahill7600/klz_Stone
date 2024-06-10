import "package:flutter/material.dart";
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatefulWidget {
  final String? image;

  FullScreenImage({
    @required this.image,
  });

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child:PhotoView(
          imageProvider: NetworkImage(widget.image!),
        )));
  }
}
