import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_a/models/new_channel_headline_model.dart';
import 'package:new_a/models/categories_new_model.dart';

class NewRepository {
  Future<NewChanelHeadlineModel> fetchNewChannelHeadlinesApi(
      String name) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$name&apiKey=5e8b1e11daf348b198590e4ae9be9a44';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewChanelHeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }
}

class CategoriesNew {
  Future<CategoriesNewModel> fetchCatogoriesNewModel(String key) async {
    String url =
        'https://newsapi.org/v2/top-headlines?q=$key&apiKey=5e8b1e11daf348b198590e4ae9be9a44';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
