import 'package:flutter/material.dart';

class CustomListInfo extends StatelessWidget {
  const CustomListInfo({Key key, this.title, this.info, this.icon})
      : super(key: key);

  final String title;
  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          icon != null
              ? RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headline4,
                      children: [
                      TextSpan(text: info),
                      WidgetSpan(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          icon,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                    ]))
              : Text(
                  info,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 3,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
