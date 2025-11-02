import 'package:equatable/equatable.dart';
import 'movie.dart';

class MovieDetail extends Equatable {
  final Movie movie;
  final int? runtime;
  final List<String>? genres;
  final String? tagline;
  final String? productionCompanies;
  final int? budget;
  final int? revenue;
  
  const MovieDetail({
    required this.movie,
    this.runtime,
    this.genres,
    this.tagline,
    this.productionCompanies,
    this.budget,
    this.revenue,
  });
  
  @override
  List<Object?> get props => [
    movie,
    runtime,
    genres,
    tagline,
    productionCompanies,
    budget,
    revenue,
  ];
}

