import 'package:flutter/material.dart';
import 'dart:async';

import '../models/item_model.dart';
import './loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          // shows top level comments
          //Text(snapshot.data.text),
          ListTile(
            title: buildText(item),
            subtitle: item.by != "" ? Text(item.by) : Text('Deleted'),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: 16.0 * depth,
            ),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
        //return Text(snapshot.data.text);
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x2F;', '/')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');

    return Text(text);
  }
}
