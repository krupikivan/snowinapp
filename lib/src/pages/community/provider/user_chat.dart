import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/widgets/custom_appbar_chat.dart';
import 'package:snowin/src/widgets/custom_chat_message.dart';
import 'package:snowin/src/widgets/main_menu.dart';

class UserChat extends StatefulWidget {
  const UserChat({Key key}) : super(key: key);
  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarChat(
            scaffoldDrawer: scaffoldDrawer,
            context: context,
          ),
          preferredSize: Size(double.infinity, 70)),
      bottomNavigationBar: MainMenu(
        item: 2,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Column(children: <Widget>[
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

// Input text message
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
            onSubmitted: _handleSubmitted,
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
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            )),
      ]),
    );
  }

  void _handleSubmitted(String text) {
    final user = Provider.of<UserProvider>(context, listen: false);
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    final ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
      name: user.userTapped.nombre,
    );
    setState(() {
      _messages.insert(0, message);
      // final data =
      //     user.userList.firstWhere((u) => u.nombre == user.userTapped.nombre);
      // data.message = message.text;
    });
    message.animationController.forward();
  }
}
