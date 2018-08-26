import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(children: [
      ListTile(
        title: buildPlaceholderBoxes(),
        subtitle: buildPlaceholderBoxes(),
      ),
      Divider(
        height: 8.0,
      ),
    ]);
  }

  buildPlaceholderBoxes() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          height: 25.0,
          width: 150.0,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        ),
        Container(
          color: Colors.grey[300],
          height: 20.0,
          width: 100.0,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        ),
      ],
    );
  }
}
