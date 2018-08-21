import 'dart:async';
import 'news_db_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final NewsApiProvider apiProvider = NewsApiProvider();
  final NewsDbProvider dbProvier = NewsDbProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvier.fetchItem(id);
    if (item != null) {
      return item;
    }

    // add to local storage DB
    item = await apiProvider.fetchItem(id);
    // not marked await as success is not mandatory here
    dbProvier.addItem(item);

    return item;
  }
}
