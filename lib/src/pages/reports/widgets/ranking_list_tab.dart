import 'package:flutter/material.dart';

import 'package:snowin/src/models/ranking.dart';

import 'package:snowin/src/providers/snowin_provider.dart';

import 'package:snowin/src/pages/reports/widgets/ranking_tile.dart';



class RankingListTab extends StatefulWidget {

  RankingListTab({ Key key}) : super(key: key);

  @override
  RankingListTabState createState() => new RankingListTabState();
}

class RankingListTabState extends State<RankingListTab> {

  double deviceHeight = 0;
  int page = 0, qtty = 5;
  bool _isLoading = false, _showTopButon = false;
  ScrollController _scrollController;
  List<Ranking> _allRanking = new List<Ranking>();



  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController()..addListener(scrollListener);
    startLoader();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical:15),
      child: new RefreshIndicator(
                  child: new Scrollbar(
                    child: new Stack(
                          children: <Widget>[
                              buildRankingTiles(),
                              buildflotingActionButtons(),
                              //buildLoader(),
                              //buildGoTopButton(),
                          ],
                      ),
                  ),
                  onRefresh: refreshing,
                ),
    );
  }



//////////////////////////////////////////////////////////////////////////// Widget
  Widget buildRankingTiles() {
    return _allRanking.length > 0?
            new ListView.builder(
                padding: const EdgeInsets.all(5.0),
                controller: _scrollController,
                itemCount: _allRanking.length + 1,
                itemBuilder: (context, i) {
                  if(i < _allRanking.length)
                      return RankingTile(ranking: _allRanking[i]);
                  else
                      return SizedBox(height: 70.0);
                })
                :
                _isLoading?
                      new ListTile(
                        title: new Text('Buscando ...'),
                      )
                      :
                      new ListTile(
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
                  _isLoading?
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(child: new CircularProgressIndicator(
                                                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                                      ))),
                        ) : new SizedBox(width: 0.0, height: 0.0),
                  SizedBox(width: 10,),
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Color.fromRGBO(29, 29, 27, 1.0),
                    child: Icon(Icons.filter_list),
                    onPressed: (){}
                  ),
                  // SizedBox(width: 10,),
                  // FloatingActionButton(
                  //   heroTag: "btn2",
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   child: Icon(Icons.add),
                  //   onPressed: (){}
                  // ),
                  SizedBox(width: 10,),
                  _showTopButon?
                        FloatingActionButton(
                          heroTag: "btn3",
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.expand_less),
                          onPressed: () {
                              _scrollController.animateTo(0.0, duration: new Duration(seconds: (page < 3? page : 3)), curve: Curves.ease);
                          },
                        ) : new SizedBox(width: 0.0, height: 0.0)
                ],
              ),
            ),
            alignment: FractionalOffset.bottomCenter,
          );
  }





//////////////////////////////////////////////////////////////////////////// Functions
  void scrollListener() {
    if (_scrollController.position.pixels > deviceHeight) {
       if(!_showTopButon) {
          setState(() {
              _showTopButon = true;
          });
       }
    } else {
      if(_showTopButon) {
        setState(() {
              _showTopButon = false;
          });
      }
    }

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        startLoader();
    }
  }

  void startLoader() {
    if(mounted) setState(() {
      _isLoading = !_isLoading;
      fetchData();
    });
  }

  fetchData() async {
    loadRanking(qtty, (page * qtty)).then((elements) {
        if(mounted) setState(() {
            if(page == 0) {
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
    setState(() { });
    startLoader();
  }

  Future<List<Ranking>> loadRanking(int limit, int offset) async {
      List<Ranking> elements = new List<Ranking>();

      await SnowinProvider().reportes(limit.toString(), offset.toString()).then((response) { print(response);
          if(response['ok']) {
              //var data = response['data'];

              // final _castDataType = response['data'].cast<Map<String, dynamic>>();
              // elements = _castDataType.map<Ranking>((json) => Ranking.map(json)).toList();
              elements = [
                            Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "67", 
                              "points": "450", 
                              "awards": "3", 
                              "comments": "12",
                              "ranking": "4",
                              "votes": "140",
                              "position": "01",
                            }),
                            Ranking.map({
                              "user": "Anaski1986", 
                              "level": "Principiante", 
                              "image": "https://mpre.center/Site/themed-images/placeholders/480x360/holder1-480x360.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "50", 
                              "points": "259", 
                              "awards": "2", 
                              "comments": "04",
                              "ranking": "3",
                              "votes": "32",
                              "position": "02",
                            }),
                            Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRIln0T3wlvVL6nps0e-jj3WPdE3zvyjvnQjPAoQN-k_EoxOF9s&usqp=CAU",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "46", 
                              "points": "230", 
                              "awards": "1", 
                              "comments": "12",
                              "ranking": "2",
                              "votes": "140",
                              "position": "03",
                            }),
                            Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                             Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                             Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                             Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                             Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                             Ranking.map({
                              "user": "Juanilu", 
                              "level": "Avanzado", 
                              "image": "https://www.clickgest.com/sites/default/files/2016-03/team4-large.jpg",
                              "time": "Hoy 10:35 AM.", 
                              "reports": "35", 
                              "points": "450", 
                              "awards": "1", 
                              "comments": "14",
                              "ranking": "3",
                              "votes": "98",
                              "position": "04",
                            }),
                          ];

          } else {
              throw new Exception('Error');
          }
      }).catchError((error) {
          print(error.toString());
      });

      return elements;
  }

}