class ReviewsModel {
  String author;
  String content;
  String id;
  String url;

  // Named Constructor
  ReviewsModel.fromJson(Map<String, dynamic> parsedJson) {
    author = parsedJson['author'];
    content = parsedJson['content'];
    id = parsedJson['id'];
    url = parsedJson['url'];
  }
}
