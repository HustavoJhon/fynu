import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import '../../core/errors/failures.dart';

class GetPopularMovies {
  final MovieRepository repository;
  
  GetPopularMovies(this.repository);
  
  Future<({Failure? failure, List<Movie>? movies})> call() {
    return repository.getPopularMovies();
  }
}

