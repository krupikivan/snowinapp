import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/notification_tab.dart';
import 'package:snowin/src/pages/community/provider/community_tab_provider.dart';
import 'package:snowin/src/pages/community/search_tab.dart';
import 'package:snowin/src/pages/community/widget/notification_avatar.dart';
import 'package:snowin/src/widgets/custom_appbar_pages.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';

import '../../widgets/main_menu.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final tab = Provider.of<CommunityTabsProvider>(context);
    if (tab.inSecondTab) {
      _tabController.index = 1;
    }
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarPages(
            scaffoldDrawer: scaffoldDrawer,
            back: false,
            context: context,
            title: "COMUNIDAD",
          ),
          preferredSize: Size(double.infinity, 70)),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      bottomNavigationBar: MainMenu(
        item: 2,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              unselectedLabelColor: Theme.of(context).disabledColor,
              labelColor: Theme.of(context).primaryColor,
              controller: _tabController,
              onTap: (val) => val == 0 ? tab.currentIndex = 0 : null,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NotificationAvatar(notif: "4"),
                    Flexible(
                      child: Tab(
                        child: FittedBox(child: Text('Notificaciones')),
                      ),
                    ),
                  ],
                ),
                Tab(
                  child: FittedBox(child: Text('Buscar Amigos')),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              NotificationsTab(),
              SearchTab(),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Consumer<CommunityTabsProvider>(
              builder: (context, tab, _) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                      heroTag: "btnFilter",
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: Icon(Icons.filter_list),
                      onPressed: () {}),
                  SizedBox(
                    width: 15,
                  ),
                  tab.currentIndex == 1
                      ? FloatingActionButton(
                          heroTag: "btnFriend",
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.person_add),
                          onPressed: () {})
                      : SizedBox(),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                      heroTag: "btnSearch",
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: Icon(Icons.search),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _flotingActionButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              heroTag: "btnFilter",
              backgroundColor: Color.fromRGBO(29, 29, 27, 1.0),
              child: Icon(Icons.filter_list),
              onPressed: () {}),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              heroTag: "btnFriend",
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.person_add),
              onPressed: () {}),
        ],
      ),
    );
  }
}
