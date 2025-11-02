import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    super.releaseDate,
    super.voteAverage,
    super.voteCount,
    super.isAdult,
    super.originalLanguage,
    super.originalTitle,
    super.genreIds,
    super.popularity,
  });
  
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? json['name'] as String? ?? 'Sin título',
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String? ?? json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      isAdult: json['adult'] as bool?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String? ?? json['original_name'] as String?,
      genreIds: json['genre_ids'] != null 
          ? List<int>.from(json['genre_ids'] as List)
          : null,
      popularity: (json['popularity'] as num?)?.toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': isAdult,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'genre_ids': genreIds,
      'popularity': popularity,
    };
  }
  
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isAdult: isAdult,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      genreIds: genreIds,
      popularity: popularity,
    );
  }
}

