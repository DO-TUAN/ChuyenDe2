import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  List<Article> _favoriteArticles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Article> get articles => _filteredArticles.isEmpty && _searchQuery.isEmpty ? _articles : _filteredArticles;
  List<Article> get favoriteArticles => _favoriteArticles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  String _searchQuery = '';

  NewsProvider() {
    fetchNews();
  }

  // Lấy dữ liệu từ API
  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _articles = data.map((json) => Article.fromJson(json)).toList();
        _filteredArticles = _articles;
      } else {
        _errorMessage = 'Lỗi máy chủ: Không thể tải tin tức';
      }
    } catch (e) {
      _errorMessage = 'Lỗi kết nối mạng. Vui lòng kiểm tra lại internet.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Chức năng tìm kiếm
  void searchNews(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredArticles = _articles;
    } else {
      _filteredArticles = _articles.where((article) {
        return article.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Quản lý Yêu thích
  void toggleFavorite(Article article) {
    if (isFavorite(article)) {
      _favoriteArticles.removeWhere((a) => a.id == article.id);
    } else {
      _favoriteArticles.add(article);
    }
    notifyListeners();
  }

  bool isFavorite(Article article) {
    return _favoriteArticles.any((a) => a.id == article.id);
  }
}