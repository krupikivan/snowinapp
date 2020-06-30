import 'package:flutter/material.dart';
import 'package:snowin/src/models/benefit.dart';

class BenefitCard extends StatelessWidget {
  const BenefitCard({Key key, this.benefit, this.action}) : super(key: key);
  final VoidCallback action;
  final Benefit benefit;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 1.2;
    return InkWell(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 1, color: Colors.grey[400]),
        ),
        height: 130,
        child: Stack(
          children: <Widget>[
            Container(
              width: width / 2.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(benefit.image)),
              ),
            ),
            Container(
              width: width / 2,
              padding: const EdgeInsets.only(right: 10, top: 20),
              margin: EdgeInsets.only(left: width / 2),
              alignment: FractionalOffset.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${benefit.discount} Dto.',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  Text(
                    benefit.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(benefit.description,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
