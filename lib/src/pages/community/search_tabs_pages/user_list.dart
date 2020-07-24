import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import '../widgets/user_tile.dart';

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<CommunityProvider>(
      builder: (context, user, _) => user.users != null
          ? Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(5.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: user.users.cantidadUsuarios,
                itemBuilder: (BuildContext context, int index) => UserTile(
                    context: context,
                    size: size,
                    userProvider: user,
                    index: index),
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black,
                  height: 1,
                ),
              ),
            )
          : user.hasConnection
              ? CircularProgressIndicator()
              : ListTile(
                  title: Text('Verifique su conexion'),
                ),
    );
  }

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<CommunityProvider>(context, listen: false).loadMore();
    }
  }
}
