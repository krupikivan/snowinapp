import 'package:flutter/material.dart';

import '../../widgets/main_menu.dart';

class Sos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("S.O.S"),
        backgroundColor: Color.fromRGBO(30, 112, 183, 1),
        leading: Icon(Icons.arrow_back),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      bottomNavigationBar: MainMenu(item: 4,),
      body: Container(
        child: Center(
          child: Text("S.O.S"),
        ),
      ),
    );
  }
}