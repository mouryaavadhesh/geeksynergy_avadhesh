class MovieResponseModel {
  List<Result> result;

  MovieResponseModel({required this.result});

  MovieResponseModel.fromJson(Map<String, dynamic> json)
      : result = (json['result'] ?? [])
            .map<Result>((json) => Result.fromJson(json))
            .toList();
}

class Result {
  final String title;
  final String poster;
  final String description;
  final String genre;
  final String language;
  final int releasedDate;
  final int runTime;
  final int pageViews;
  final int totalVoted;
  final int voting;
  final List<dynamic> director;
  final List<dynamic> stars;

  Result(
      {required this.title,
      required this.poster,
      required this.description,
      required this.genre,
      required this.director,
      required this.language,
      required this.totalVoted,
        required this.runTime,
      required this.releasedDate,
      required this.stars,
        required this.voting,
      required this.pageViews});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      title: json["title"] ?? "",
      poster: json["poster"] ?? "",
      description: json["description"] ?? "",
      pageViews: json["pageViews"] ?? "",
      language: json["language"] ?? "",
      releasedDate: json["releasedDate"] ?? 0,
      runTime: json["runTime"] ?? 0,
      voting: json["voting"] ?? 0,
      genre: json["genre"] ?? "",
      totalVoted: json["totalVoted"] ?? "",
      director: (json['director'] as List<dynamic>),
      stars: (json['stars'] as List<dynamic>));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['poster'] = poster;
    data['description'] = description;
    data['stars'] = stars;
    data['runTime'] = runTime;
    data['director'] = director;
    data['pageViews'] = pageViews;
    data['genre'] = genre;
    data['language'] = language;
    data['releasedDate'] = releasedDate;
    data['totalVoted'] = totalVoted;
    data['voting'] = voting;
    return data;
  }
}
