import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../../core/errors/failures.dart';

abstract class MovieRepository {
  Future<({Failure? failure, List<Movie>? movies})> getPopularMovies();
  Future<({Failure? failure, List<Movie>? movies})> getTrendingMovies();
  Future<({Failure? failure, List<Movie>? movies})> getTopRatedMovies();
  Future<({Failure? failure, MovieDetail? movie})> getMovieDetails(int movieId);
  Future<({Failure? failure, List<Movie>? movies})> searchMovies(String query);
}

