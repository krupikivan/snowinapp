import 'package:flutter/material.dart';

class CustomFabIcon extends StatelessWidget {
  const CustomFabIcon(
      {Key key, this.heroTag, this.icon, this.isPrimary, this.action})
      : super(key: key);

  final String heroTag;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.white)),
        heroTag: heroTag,
        backgroundColor: isPrimary
            ? Theme.of(context).primaryColor
            : Theme.of(context).backgroundColor,
        child: Icon(icon, size: 35),
        onPressed: action,
      ),
    );
  }
}
