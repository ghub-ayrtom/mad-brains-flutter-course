// Класс констант HTTP-запросов
class Query {
  static const String rapidApiUrl =
      "https://moviesdatabase.p.rapidapi.com/titles/random?list=top_rated_series_250";
  static const String rapidApiUrlSearch =
      "https://moviesdatabase.p.rapidapi.com/titles/search/title";

  static const String tvMazeApiUrl = "https://api.tvmaze.com/search/shows";
  static const String initialQ = "";
}

// Класс констант локализации
class Local {
  static const String error = "Error";
  static const String unknown = "Unknown";
  static const String search = "Search series...";
  static const String newsPagesTitle = "News";
  static const String description = "Series Description";
  static const String homePageBNBText = "Feed";
}
