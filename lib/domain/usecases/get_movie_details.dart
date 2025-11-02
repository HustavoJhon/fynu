import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';
import '../../core/errors/failures.dart';

class GetMovieDetails {
  final MovieRepository repository;
  
  GetMovieDetails(this.repository);
  
  Future<({Failure? failure, MovieDetail? movie})> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }
}

