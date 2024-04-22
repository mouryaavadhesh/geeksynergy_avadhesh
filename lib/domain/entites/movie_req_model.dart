class RequestMovieModel {
  final String category;
  final String language;
  final String genre;
  final String sort;


  const RequestMovieModel({
    required this.category,
    required this.language,
    required this.genre,
    required this.sort,
  });

  Map<String, dynamic> toMap() => {
    'category': category,
    'language': language,
    'genre': genre,
    'sort': sort,
  };

}

