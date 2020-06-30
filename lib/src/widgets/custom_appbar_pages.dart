import 'package:flutter/material.dart';

class CustomAppbarPages extends StatelessWidget {
  CustomAppbarPages({
    this.back,
    this.title = "",
    this.context,
    @required this.scaffoldDrawer,
  });
  final title;
  final GlobalKey<ScaffoldState> scaffoldDrawer;
  final bool back;
  final BuildContext context;
  final String img =
      "https://images.pexels.com/photos/714258/pexels-photo-714258.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";

  @override
  Widget build(context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image(
                image: NetworkImage(img),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                height: 90,
                color: Color.fromRGBO(74, 74, 73, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    back
                        ? IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(),
                    IconButton(
                      onPressed: () =>
                          scaffoldDrawer.currentState.openEndDrawer(),
                      icon: Icon(
                        Icons.menu,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 25),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
