import 'package:demo_app/model/image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Repository {
  Future<List<ImageModel>> getData(String filter) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0ebf7f699bf341678632885c1a232fa1');
    var response = await http.get(url, headers: {
      "Authorization":
          "563492ad6f9170000100000133d1d25e71dc4e0a908a38bc76b906fc"
    });
    List<ImageModel> images = [];
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    (jsonResponse['articles'] as List).forEach((element) {
      images.add(ImageModel.fromMap(element));
    });

    return images;
  }
}
