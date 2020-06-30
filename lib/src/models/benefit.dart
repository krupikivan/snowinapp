class Benefit {
  String image;
  String title;
  String discount;
  String description;

  Benefit({
    this.image,
    this.title,
    this.discount,
    this.description,
  });

  Benefit.fromMap(this.image, this.title, this.discount, this.description);
}
