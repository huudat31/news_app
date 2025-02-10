import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_a/models/api_key.dart';
import 'package:new_a/models/new_channel_headline_model.dart';
import 'package:new_a/models/categories_new_model.dart';

class NewRepository {
  Future<NewChanelHeadlineModel> fetchNewChannelHeadlinesApi(
      String name) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$name&apiKey=$apiKey';
    // gui request den api
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
  Future<CategoriesNewModel> fetchCategoryNewModelApi(String name) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?q=$name&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewModel.fromJson(body);
    } else {
      throw Exception('error');
    }
  }
}
