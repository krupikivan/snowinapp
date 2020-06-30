class Award {
  String date1;
  String date2;
  String detail;

  Award({
    this.date1,
    this.date2,
    this.detail,
  });

  Award.fromMap(this.date1, this.date2, this.detail);
}
