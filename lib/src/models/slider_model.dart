class SliderModel {
  String description;
  String image;
  String author;

  SliderModel({this.description, this.author, this.image});

  SliderModel.fromMap(element) {
    image = element['ruta'];
    author = element['username'];
    description = element['descripcion'];
  }
}
