import 'dart:io';

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {

  final double size;
  final String path;
  final bool showDeleteButton;
  final OnDeleteCallback onDelete;


  CustomImage({
    this.size,
    this.path,
    this.showDeleteButton = false,
    this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Stack(
        children: [
          (path.indexOf('http') == 0)?
                Image(
                  height: size,
                  width: size,
                  image:  NetworkImage(path),
                  fit: BoxFit.cover,
                )
                :
                new Image.file(File(path),
                  height: size,
                  width: size,
                  fit: BoxFit.cover
                ),
          Padding(
              padding: new EdgeInsets.only(left: size*0.5, top: size*0.5),
              child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.red,),
                onPressed: onDelete,
              )
          )
        ],
      ),
    );
  }
}



typedef OnDeleteCallback = void Function();
