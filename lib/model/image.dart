import 'dart:convert';

class ImageModel {
  final String? urlToImage;
  final String? title;
  final int? height;
  final int? width;
  ImageModel({
    this.urlToImage,
    this.title,
    this.height,
    this.width,
  });

  Map<String, dynamic> toMap() {
    return {
      'urlToImage': urlToImage,
      'title': title,
      'height': height,
      'width': width,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      urlToImage: map['urlToImage'],
      title: map['title'],
      height: map['height'],
      width: map['width'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));
}
