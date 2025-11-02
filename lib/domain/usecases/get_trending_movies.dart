import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import '../../core/errors/failures.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  
  GetTrendingMovies(this.repository);
  
  Future<({Failure? failure, List<Movie>? movies})> call() {
    return repository.getTrendingMovies();
  }
}

