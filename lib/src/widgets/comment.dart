import 'package:flutter/material.dart';
import 'dart:async';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading comment...');
        }

        final children = <Widget>[
          // shows top level comments
          Text(snapshot.data.text),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
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
}
