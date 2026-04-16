import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/news_provider.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<NewsProvider>(context).favoriteArticles;

    return Scaffold(
      appBar: AppBar(title: Text('Tin tức yêu thích')),
      body: favorites.isEmpty
          ? Center(child: Text('Chưa có bài báo yêu thích nào.'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final article = favorites[index];
          return ListTile(
            leading: Image.network(article.imageUrl, width: 80, fit: BoxFit.cover),
            title: Text(article.title, maxLines: 2),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(article: article)));
            },
          );
        },
      ),
    );
  }
}