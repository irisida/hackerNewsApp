import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'repository.dart';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  // consructor calls init method
  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
            CREATE TABLE items (
              id INTEGER PRIMARY KEY,
              by TEXT,
              type TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER, 
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
          """);
    });
  }

  Future<List<int>> fetchTopIds() {
    // todo - store and fetch top ids
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "items",
      columns: null,
      where: "id=?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("items", item.toMap());
  }

  Future<int> clear() {
    return db.delete("items");
  }
}

// decare single instance to avoid multiple connection gotchas
final newsDbProvider = NewsDbProvider();
