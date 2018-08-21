import 'package:news_app/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    // setup instance of class being tested
    final newsApi = NewsApiProvider();
    // override the client to use mockClint
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    // make the mock call
    final ids = await newsApi.fetchTopIds();

    // check the expectation
    expect(ids, [1, 2, 3, 4, 5]);
  });

  test('fetchItem returns an ItemModel', () async {
    // setup instance of class being tested
    final newsApi = NewsApiProvider();
    // override the cient to use mockclient
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 12345};
      return Response(json.encode(jsonMap), 200);
    });

    // make the mock call
    final item = await newsApi.fetchItem(100);

    // check the expectation
    expect(item.id, 12345);
  });
}
