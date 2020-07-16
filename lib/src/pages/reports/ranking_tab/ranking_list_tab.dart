import 'package:flutter/material.dart';

import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/repository/report_repository.dart';

import 'package:snowin/src/repository/snowin_repository.dart';

import 'package:snowin/src/pages/reports/ranking_tab/ranking_tile.dart';

class RankingListTab extends StatefulWidget {
  RankingListTab({Key key}) : super(key: key);

  @override
  RankingListTabState createState() => new RankingListTabState();
}

class RankingListTabState extends State<RankingListTab> {
  double deviceHeight = 0;
  int page = 0, qtty = 5;
  bool _isLoading = false, _showTopButon = false;
  ScrollController _scrollController;
  List<User> _allRanking = new List<User>();

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(scrollListener);

    startLoader();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: new RefreshIndicator(
        child: new Scrollbar(
          child: new Stack(
            children: <Widget>[
              buildRankingTiles(),
              buildflotingActionButtons(),
            ],
          ),
        ),
        onRefresh: refreshing,
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////// Widget
  Widget buildRankingTiles() {
    return _allRanking.length > 0
        ? new ListView.builder(
            padding: const EdgeInsets.all(5.0),
            controller: _scrollController,
            itemCount: _allRanking.length + 1,
            itemBuilder: (context, i) {
              if (i < _allRanking.length)
                return RankingTile(
                  ranking: _allRanking[i],
                  index: i,
                );
              else
                return SizedBox(height: 70.0);
            })
        : _isLoading
            ? new ListTile(
                title: new Text('Buscando ...'),
              )
            : new ListTile(
                title: new Text('No hay registros'),
              );
  }

  Widget buildflotingActionButtons() {
    return new Align(
      child: Container(
        margin: EdgeInsets.only(left: 32, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? Container(
                    width: 50.0,
                    height: 50.0,
                    child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Center(
                            child: new CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))),
                  )
                : new SizedBox(width: 0.0, height: 0.0),
            SizedBox(
              width: 10,
            ),
            _showTopButon
                ? FloatingActionButton(
                    heroTag: "btn3",
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.expand_less),
                    onPressed: () {
                      _scrollController.animateTo(0.0,
                          duration:
                              new Duration(seconds: (page < 3 ? page : 3)),
                          curve: Curves.ease);
                    },
                  )
                : new SizedBox(width: 0.0, height: 0.0)
          ],
        ),
      ),
      alignment: FractionalOffset.bottomCenter,
    );
  }

//////////////////////////////////////////////////////////////////////////// Functions
  void scrollListener() {
    if (_scrollController.position.pixels > deviceHeight) {
      if (!_showTopButon) {
        setState(() {
          _showTopButon = true;
        });
      }
    } else {
      if (_showTopButon) {
        setState(() {
          _showTopButon = false;
        });
      }
    }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      startLoader();
    }
  }

  void startLoader() {
    if (mounted)
      setState(() {
        _isLoading = !_isLoading;
        fetchData();
      });
  }

  fetchData() async {
    loadRanking(qtty, (page * qtty)).then((elements) {
      if (mounted)
        setState(() {
          if (page == 0) {
            _allRanking.clear();
          }

          setState(() {
            _allRanking.addAll(elements);
            _isLoading = !_isLoading;
            page++;
          });
        });
    }).whenComplete(() {
      print('done');
    });
  }

  Future<Null> refreshing() async {
    print(" refreshing ... ");
    page = 0;
    _allRanking.clear();
    setState(() {});
    startLoader();
  }

  Future<List<User>> loadRanking(int limit, int offset) async {
    List<User> elements = new List<User>();

    await ReportRepository()
        .rankings(limit.toString(), offset.toString())
        .then((response) {
      print('listar-ranking: ');
      print(response);
      if (response['ok']) {
        final _castDataType = response['data'].cast<Map<String, dynamic>>();
        elements = _castDataType.map<User>((json) => User.map(json)).toList();
      } else {
        throw new Exception('Error');
      }
    }).catchError((error) {
      print(error.toString());
    });

    return elements;
  }
}
