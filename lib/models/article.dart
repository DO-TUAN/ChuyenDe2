class Article {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      description: json['body'] ?? 'No Description',
      // Dùng picsum để tạo ảnh random dựa trên ID bài viết
      imageUrl: 'https://picsum.photos/seed/${json['id']}/400/200',
      date: DateTime.now().toString().substring(0, 10),
    );
  }
}