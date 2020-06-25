import 'package:flutter/material.dart';

import '../../widgets/main_menu.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("COMUNIDAD"),
        backgroundColor: Color.fromRGBO(30, 112, 183, 1),
        leading: Icon(Icons.arrow_back),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      bottomNavigationBar: MainMenu(item: 2,),
      body: Container(
        child: Center(
          child: Text("Comunidad"),
        ),
      ),
    );
  }
}