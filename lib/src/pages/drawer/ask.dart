import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:snowin/src/pages/drawer/widget/custom_appbar_drawer.dart';
import 'package:snowin/src/widgets/custom_chat_message.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';

class Ask extends StatefulWidget {
  Ask({Key key}) : super(key: key);

  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarDrawer(
            scaffoldDrawer: scaffoldDrawer,
            context: context,
            showLogo: true,
            title: "SNOWIN CONSULTAS",
          ),
          preferredSize: Size(double.infinity, 70)),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomMenu(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Column(children: <Widget>[
          Bubble(
            alignment: Alignment.center,
            elevation: 0,
            padding: BubbleEdges.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            margin: BubbleEdges.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Text('Envianos tu consulta para el equipo de Snowin',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700])),
                SizedBox(
                  height: 5,
                ),
                Text('Te responderemos a la brevedad',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]))
              ],
            ),
          ),
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          )),
          _buildTextComposer(),
        ]),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textController,
            onChanged: (String text) {
              setState(() {
                _isComposing = text.isNotEmpty;
              });
            },
            onSubmitted: null,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: _isComposing ? () => null : null,
              ),
            )),
      ]),
    );
  }

  // void _handleSubmitted(String text) {
  //   final user = Provider.of<UserProvider>(context, listen: false);
  //   _textController.clear();
  //   setState(() {
  //     _isComposing = false;
  //   });
  //   final ChatMessage message = ChatMessage(
  //     text: text,
  //     animationController: AnimationController(
  //       duration: Duration(milliseconds: 700),
  //       vsync: this,
  //     ),
  //     name: user.currentUser.nombre, //We need to pass user params
  //   );
  //   setState(() {
  //     _messages.insert(0, message);
  //     // final data =
  //     //     user.userList.firstWhere((u) => u.nombre == user.currentUser.nombre);
  //     // data.message = message.text;
  //   });
  //   message.animationController.forward();
  // }
}
