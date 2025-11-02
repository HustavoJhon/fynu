import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import '../../core/errors/failures.dart';

class SearchMovies {
  final MovieRepository repository;
  
  SearchMovies(this.repository);
  
  Future<({Failure? failure, List<Movie>? movies})> call(String query) {
    return repository.searchMovies(query);
  }
}

