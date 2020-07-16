class ReportComments {
  var comentario;

  ReportComments(
    this.comentario,
  );

  ReportComments.map(dynamic data) {
    this.comentario =
        data.containsKey('comentario') ? data['comentario'].toString() : "";
  }
}
