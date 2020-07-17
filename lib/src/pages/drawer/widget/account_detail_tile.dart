import 'package:flutter/material.dart';

class AccountDetailTile extends StatelessWidget {
  const AccountDetailTile({Key key, this.title, this.action}) : super(key: key);
  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: action,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.headline2.apply(color: Colors.grey),
          ),
        ),
        Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Colors.black,
        )
      ],
    );
  }
}
