class MovieDetails {
  int id;
  String backdrop_path;
  double budget;
  List<Map<dynamic>> genres;
  String original_title;
  String overview;
  String popularity;
  String poster_path;
  List<Map<dynamic>> production_companies;
  String release_date;
  double revenue;
  String tagline;
  String title;
  String vote_average;
  double vote_count;

  // Named constructor
  MovieDetails.fromJson(Map<String, dynamic> parsedJson){
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