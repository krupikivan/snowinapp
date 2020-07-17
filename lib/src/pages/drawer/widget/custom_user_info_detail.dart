import 'package:flutter/material.dart';

class CustomUserInfoDetail extends StatelessWidget {
  const CustomUserInfoDetail(
      {Key key, this.info, this.title1, this.title2, this.action})
      : super(key: key);

  final String title1;
  final String title2;
  final String info;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: action,
            trailing: Icon(Icons.edit),
            isThreeLine: title2 != null ? true : false,
            title: Text(info, style: Theme.of(context).textTheme.headline4),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title1 ?? '',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: title2 != null ? 5 : 0,
                ),
                title2 != null
                    ? Text(
                        title2,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3,
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Divider(
            height: 1,
            indent: 16,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
