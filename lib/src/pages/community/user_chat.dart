import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/message.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'package:snowin/src/widgets/custom_appbar_chat.dart';
import 'package:snowin/src/widgets/custom_chat_message.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';

class UserChat extends StatefulWidget {
  const UserChat({Key key}) : super(key: key);
  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> with TickerProviderStateMixin {
  // final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController =
      new TextEditingController(text: '');
  // bool _isComposing = false;
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // message.animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    final int userId =
        Provider.of<CommunityProvider>(context, listen: false).userTapped.id;
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarChat(
            scaffoldDrawer: scaffoldDrawer,
            context: context,
          ),
          preferredSize: Size(double.infinity, 70)),
      bottomNavigationBar: CustomBottomMenu(
        item: 2,
      ),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      body: Consumer<ChatProvider>(builder: (context, chat, _) {
        if (chat.messageList == null || chat.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          List<ChatMessage> _list = [];
          chat.messageList
              .sort((a, b) => DateTime.parse(b.fecha).millisecondsSinceEpoch);
          chat.messageList.forEach((element) {
            final ChatMessage message = ChatMessage(
              message: element,
              animationController: AnimationController(
                duration: Duration(milliseconds: 700),
                vsync: this,
              ),
              fecha: element.fecha,
            );
            _list.insert(0, message);
            message.animationController.fling();
          });
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: Column(children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: _list.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                            onLongPress: () =>
                                _showPopup(_list[index].message.id, chat),
                            child: _list[index]);
                      })),
              _buildTextComposer(chat, userId),
            ]),
          );
        }
      }),
    );
  }

// Input text message
  Widget _buildTextComposer(ChatProvider chat, int userId) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textController,
            onChanged: (String text) {
              // setState(() {
              // _isComposing = text.isNotEmpty;
              // });
            },
            onSubmitted: null, //_handleSubmitted,
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
        InkWell(
          onTap: () => _send(chat, userId),
          child: Container(
              margin: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.send, color: Colors.white),
              )),
        ),
      ]),
    );
  }

  _send(ChatProvider chat, userId) {
    if (_textController.text.isNotEmpty) {
      chat
          .sendMessage(_textController.text, userId)
          .then((value) => value ? _textController.clear() : print(''));
    } else {
      print('Text:' + _textController.text.isNotEmpty.toString());
    }
  }

  _showPopup(int id, ChatProvider chat) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          FlatButton(
            child: Text('Borrar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              chat.delete(id);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cancelar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Text('Seguro quiere borrar este mensaje?')),
      ),
    );
  }

  // void _handleSubmitted(String text) {
  //   final user = Provider.of<CommunityProvider>(context, listen: false);
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
  //     name: user.userTapped.nombre,
  //   );
  //   setState(() {
  //     _messages.insert(0, message);
  // final data =
  //     user.userList.firstWhere((u) => u.nombre == user.userTapped.nombre);
  // data.message = message.text;
  //   });
  //   message.animationController.forward();
  // }
}
