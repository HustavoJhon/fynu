import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final bool? isAdult;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
  final double? popularity;
  
  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.isAdult,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.popularity,
  });
  
  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    backdropPath,
    releaseDate,
    voteAverage,
    voteCount,
    isAdult,
    originalLanguage,
    originalTitle,
    genreIds,
    popularity,
  ];
  
  Movie copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    double? voteAverage,
    int? voteCount,
    bool? isAdult,
    String? originalLanguage,
    String? originalTitle,
    List<int>? genreIds,
    double? popularity,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      isAdult: isAdult ?? this.isAdult,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
    );
  }
}

