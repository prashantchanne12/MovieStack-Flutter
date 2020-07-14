class MovieDetailsModel {
  int id;
  String backdrop_path;
  int budget;
  List<dynamic> genres;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<dynamic> production_companies;
  String release_date;
  int revenue;
  String tagline;
  String title;
  double vote_average;
  int vote_count;

  // Named constructor
  MovieDetailsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    backdrop_path = parsedJson['backdrop_path'];
    budget = parsedJson['budget'];
    genres = parsedJson['genres'];
    original_title = parsedJson['original_title'];
    overview = parsedJson['overview'];
    popularity = parsedJson['popularity'];
    poster_path = parsedJson['poster_path'];
    production_companies = parsedJson['production_companies'];
    release_date = parsedJson['release_date'];
    revenue = parsedJson['revenue'];
    tagline = parsedJson['tagline'];
    title = parsedJson['title'];
    vote_average = parsedJson['vote_average'];
    vote_count = parsedJson['vote_count'];
  }
}
