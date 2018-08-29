import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'FooBar News',
          onGenerateRoute: routes,
          home: NewsList(),
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(
            settings.name.replaceFirst('/', '')); // remove preceeding / from id

        // fetches top level item with comments
        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetail(
          itemId: itemId,
        );
      });
    }
  }
}
