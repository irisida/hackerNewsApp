import 'dart:async';
import 'news_db_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';

// define the abstract classes required for the
// Repository class to function.

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider, // references the single instance created
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider, // references the single instance created
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1]
        .fetchTopIds(); // forced hand call of NewsApiProvide() located in sources
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    // travese the sources to find a matching
    // source containing the item.
    // It looks at the sources lost and checks each in turn
    // therefore the NewsDbProvider then NewsApiProvider
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}
