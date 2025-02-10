// import 'package:flutter/foundation.dart';
import 'package:new_a/models/categories_new_model.dart';
import 'package:new_a/models/new_channel_headline_model.dart';
import 'package:new_a/repositories/new_repository.dart';

class NewViewModel {
  final _rep = NewRepository();
  Future<NewChanelHeadlineModel> fetchNewChannelHeadlinesApi(
      String name) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(name);
    return response;
  }

  final _rep2 = CategoriesNew();
  Future<CategoriesNewModel> fetchCategoryNewModelApi(String key) async {
    final response = await _rep2.fetchCategoryNewModelApi(key);
    return response;
  }
}
