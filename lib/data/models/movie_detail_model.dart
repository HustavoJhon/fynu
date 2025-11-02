import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/movie.dart';
import 'movie_model.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.movie,
    super.runtime,
    super.genres,
    super.tagline,
    super.productionCompanies,
    super.budget,
    super.revenue,
  });
  
  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    final movie = MovieModel.fromJson(json);
    
    return MovieDetailModel(
      movie: movie.toEntity(),
      runtime: json['runtime'] as int?,
      genres: json['genres'] != null
          ? (json['genres'] as List)
              .map((g) => (g as Map<String, dynamic>)['name'] as String)
              .toList()
          : null,
      tagline: json['tagline'] as String?,
      productionCompanies: json['production_companies'] != null
          ? (json['production_companies'] as List)
              .map((c) => (c as Map<String, dynamic>)['name'] as String)
              .join(', ')
          : null,
      budget: json['budget'] as int?,
      revenue: json['revenue'] as int?,
    );
  }
  
  MovieDetail toEntity() {
    return MovieDetail(
      movie: movie,
      runtime: runtime,
      genres: genres,
      tagline: tagline,
      productionCompanies: productionCompanies,
      budget: budget,
      revenue: revenue,
    );
  }
}

