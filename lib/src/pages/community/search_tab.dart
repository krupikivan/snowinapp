import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/provider/export.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/export.dart';

class SearchTab extends StatelessWidget {
  SearchTab({Key key}) : super(key: key);
  final String txt = "5 Amigos y 29 usuarios en Chapelco";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        txt,
                      ),
                    )),
                Flexible(child: Icon(Icons.location_on)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _getListIcon('Lista', Icons.view_list, 0, context),
                _getListIcon('Perfil', Icons.view_column, 1, context),
                _getListIcon('Mapa', Icons.map, 2, context),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
          Consumer<CommunityTabsProvider>(builder: (context, tab, _) {
            tab.inSecondTab = true;
            switch (tab.currentIndex) {
              case 0:
                return UserList();
              case 1:
                return UserSwipe();
              case 2:
                return UserMap();
              default:
                return UserList();
            }
          }),
        ],
      ),
    );
  }

  Widget _getListIcon(String name, IconData icon, int index, context) {
    final tab = Provider.of<CommunityTabsProvider>(context);
    return RaisedButton(
      onPressed: () => tab.currentIndex = index,
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: tab.currentIndex == index ? Colors.black : Colors.grey[500],
          ),
          Text(
            name,
            style: TextStyle(
                color: tab.currentIndex == index
                    ? Colors.black
                    : Colors.grey[500]),
          )
        ],
      ),
    );
  }
}
