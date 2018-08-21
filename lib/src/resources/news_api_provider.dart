import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

final _apiRoot = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  // uses client class to specifically allow
  // overriding with the mockClient class in testing
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_apiRoot/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_apiRoot/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}