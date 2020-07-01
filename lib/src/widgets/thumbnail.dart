import 'dart:io';
import 'package:flutter/material.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';


class Thumbnail extends StatefulWidget {
  final bool isVideo;
  final double size;
  final String path;
  final bool showDeleteButton;
  final OnDeleteCallback onDelete;

  Thumbnail({ Key key, this.isVideo = false, this.size, this.path, this.showDeleteButton, this.onDelete}) : super(key: key);

  @override
  ThumbnailState createState() => new ThumbnailState(isVideo, size, path, showDeleteButton);
}

class ThumbnailState extends State<Thumbnail> {
  bool isVideo;
  double size;
  String path;
  bool showDeleteButton;

  ThumbnailState(this.isVideo, this.size, this.path, this.showDeleteButton);

  String _localPath = '';


  @override
  void initState() {
    super.initState();

    if(isVideo) generateThumbnail();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Stack(
        children: [
          isVideo?    ///////////////////////////////// video
                ((_localPath.isNotEmpty)?
                      Image.file(File(_localPath),
                        height: size,
                        width: size,
                        fit: BoxFit.cover
                      )
                      :
                      Image.asset('assets/images/no_image.png',
                        height: size,
                        width: size,
                        fit: BoxFit.cover
                      )
                )
                :     ///////////////////////////////// image
                ((path.indexOf('http') == 0)?
                      Image(
                        height: size,
                        width: size,
                        image:  NetworkImage(path),
                        fit: BoxFit.cover,
                      )
                      :
                      Image.file(File(path),
                        height: size,
                        width: size,
                        fit: BoxFit.cover
                      )
                ),
          Padding(
              padding: EdgeInsets.only(left: 5, top: 5),
              child: Icon(isVideo? Icons.videocam : Icons.image, color: Colors.grey, size: 15.0),
          ),
          Padding(
              padding: EdgeInsets.only(left: size*0.5, top: size*0.5),
              child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.red,),
                onPressed: widget.onDelete,
              )
          )
        ],
      ),
    );
  }

  void generateThumbnail() async {
      VideoThumbnail.thumbnailFile(
          video: path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxHeight: 64,
          quality: 25,
        ).then((value) {
            setState(() {
                _localPath = value;
            });
        });
  }

}



typedef OnDeleteCallback = void Function();
