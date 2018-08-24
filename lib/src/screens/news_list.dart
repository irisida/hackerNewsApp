import 'package:flutter/material.dart';
import 'dart:async';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top News Stories')),
      body: buildList(),
    );
  }

  // demo of the futureBuilder that shows us
  // the fetch routine to grab just enough to
  // fill the screen and the subsequent calls
  // on scroll down and new future calls being
  // fetched and returned.
  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
              height: 100.0,
              child: snapshot.hasData
                  ? Text('$index Future has returned!')
                  : Text('$index data is not visible'),
            );
          },
        );
      },
    );
  }

  // mock future with delay of 2 secs
  getFuture() {
    return Future.delayed(Duration(seconds: 2), () => 'Hi there');
  }
}
