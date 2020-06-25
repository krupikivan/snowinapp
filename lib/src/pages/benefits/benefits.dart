import 'package:flutter/material.dart';

import '../../widgets/main_menu.dart';

class Benefits extends StatefulWidget {
  @override
  _BenefitsState createState() => _BenefitsState();
}

class _BenefitsState extends State<Benefits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BENEFICIOS"),
        backgroundColor: Color.fromRGBO(30, 112, 183, 1),
        leading: Icon(Icons.arrow_back),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      bottomNavigationBar: MainMenu(item: 3,),
      body: Container(
        child: Center(
          child: Text("Beneficios"),
        ),
      ),
    );
  }
}