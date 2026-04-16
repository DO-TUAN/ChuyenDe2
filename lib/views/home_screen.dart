import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/news_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    // Xử lý hiển thị lỗi bằng SnackBar
    if (newsProvider.errorMessage.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(newsProvider.errorMessage), backgroundColor: Colors.red),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm tin tức...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => newsProvider.searchNews(value),
            ),
          ),
          Expanded(
            child: newsProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: newsProvider.fetchNews,
              child: ListView.builder(
                itemCount: newsProvider.articles.length,
                itemBuilder: (context, index) {
                  final article = newsProvider.articles[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      leading: Image.network(article.imageUrl, width: 80, fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Icon(Icons.error)),
                      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitle: Text('${article.date}\n${article.description}', maxLines: 2, overflow: TextOverflow.ellipsis),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(article: article)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}