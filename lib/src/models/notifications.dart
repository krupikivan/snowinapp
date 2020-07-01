class Notifications {
  var id;
  var user;
  var level;
  var image;
  var time;
  var reports;
  var points;
  var awards;
  var comments;
  var ranking;
  var votes;
  var position;

  Notifications(this.id, this.user, this.level, this.image, this.time, this.reports, this.points, this.awards,
          this.comments, this.ranking, this.votes, this.position);

  Notifications.map(dynamic data) {
    this.id = data.containsKey('id')? data['id'] : 0;
    this.user = data.containsKey('user')? data['user'].toString() : "";
    this.level = data.containsKey('level')? data['level'].toString() : "";
    this.image= data.containsKey('image')? data['image'].toString() : "";
    this.time= data.containsKey('time')? data['time'].toString() : "";
    this.reports = data.containsKey('reports')? data['reports'].toString() : "";
    this.points = data.containsKey('points')? data['points'].toString() : "";
    this.awards = data.containsKey('awards')? data['awards'].toString() : "";
    this.comments= data.containsKey('comments')? data['comments'].toString() : "";
    this.ranking = data.containsKey('ranking')? data['ranking'].toString() : "";
    this.votes = data.containsKey('votes')? data['votes'].toString() : "";
    this.position = data.containsKey('position')? data['position'].toString() : "";
  }
}