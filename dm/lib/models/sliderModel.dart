class SliderModel{
  String id,image,name,description;

  SliderModel({this.id,this.image, this.name, this.description});
  SliderModel.fromJson(Map<String, dynamic> jsonMap) {
    // name = jsonMap['name'].toString();
    image = jsonMap['image'].toString();

  }
}