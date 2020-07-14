class TvDetailsModel {
  int id;
  String backdrop_path;
  String first_air_date;
  List<dynamic> genres;
  String last_air_date;
  String name;
  int number_of_episodes;
  int number_of_seasons;
  String overview;
  double popularity;
  String poster_path;
  double vote_average;
  List<dynamic> origin_country;
  List<dynamic> seasons;
  int vote_count;

  // Named Constructor
  TvDetailsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    backdrop_path = parsedJson['backdrop_path'];
    first_air_date = parsedJson['first_air_date'];
    genres = parsedJson['genres'];
    last_air_date = parsedJson['last_air_date'];
    name = parsedJson['name'];
    number_of_episodes = parsedJson['number_of_episodes'];
    number_of_seasons = parsedJson['number_of_seasons'];
    overview = parsedJson['overview'];
    popularity = parsedJson['popularity'];
    poster_path = parsedJson['poster_path'];
    vote_average = parsedJson['vote_average'];
    origin_country = parsedJson['origin_country'];
    seasons = parsedJson['seasons'];
    vote_count = parsedJson['vote_count'];
  }
}
