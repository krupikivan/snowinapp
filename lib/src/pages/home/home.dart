import 'package:flutter/material.dart';

import '../../widgets/main_menu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MI PERFIL",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: Color.fromRGBO(30, 112, 183, 1),
        leading: Icon(Icons.arrow_back),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      bottomNavigationBar: MainMenu(
        item: 1,
      ),
      body: Container(
        child: ListView(
          children: [
            Divider(
              height: 1,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 240,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      color: Color.fromRGBO(49, 48, 47, 1),
                    ),
                  ),
                  Positioned(
                    top: 105,
                    right: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            "Nombre de Usuario",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            "Juan Carlos 89",
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 68,
                              backgroundImage: NetworkImage(
                                  "https://www.w3schools.com/w3css/img_avatar2.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      "PERFIL PUBLICO EN ",
                      style: TextStyle(
                          color: Color.fromRGBO(30, 112, 183, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bio",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Enfermero de nieve.",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "De julio a agosto en Chap",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "Rosario, Santa Fe, Argentina",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Práctica",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Aki y Snowboard",
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nivel",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Intermedio.",
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 20, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "MIS REPORTES",
                      style: TextStyle(
                          color: Color.fromRGBO(30, 112, 183, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: size.width * 0.29,
                          child: Column(
                            children: [
                              Text(
                                "Publicados",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "150",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 40,
                          width: 1,
                        ),
                        Container(
                          width: size.width * 0.29,
                          child: Column(
                            children: [
                              Text(
                                "Puntos",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "232",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 40,
                          width: 1,
                        ),
                        Container(
                          width: size.width * 0.29,
                          child: Column(
                            children: [
                              Text(
                                "Ranking",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "10",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 15, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "COMUNIDAD",
                      style: TextStyle(
                          color: Color.fromRGBO(30, 112, 183, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.width * 0.29,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Amigos",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "345",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        height: 40,
                        width: 1,
                      ),
                      Container(
                        width: size.width * 0.29,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Mensajes",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "345",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromRGBO(0, 159, 228, 1)),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        height: 40,
                        width: 1,
                      ),
                      Container(
                        width: size.width * 0.29,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Solicitudes",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "03",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromRGBO(230, 1, 126, 1)),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 15, color: Colors.black),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Mi CUENTA",
                      style: TextStyle(
                          color: Color.fromRGBO(30, 112, 183, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notificaciones",
                        style: TextStyle(fontSize: 21),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Privacidad",
                        style: TextStyle(fontSize: 21),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reportar un problema",
                        style: TextStyle(fontSize: 21),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Salir de mi cuenta",
                        style: TextStyle(fontSize: 21),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Divider(height: 5, color: Colors.black),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
