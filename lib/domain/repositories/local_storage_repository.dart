import '../entities/movie.dart';
import '../../core/errors/failures.dart';

abstract class LocalStorageRepository {
  Future<({Failure? failure, List<Movie>? movies})> getWatchedMovies();
  Future<({Failure? failure, List<Movie>? movies})> getWantToWatchMovies();
  Future<({Failure? failure, List<Movie>? movies})> getWithGirlfriendMovies();
  Future<({Failure? failure, List<Movie>? movies})> getLikedMovies();
  Future<({Failure? failure, List<Movie>? movies})> getDislikedMovies();
  
  Future<({Failure? failure, bool? success})> saveWatchedMovie(Movie movie);
  Future<({Failure? failure, bool? success})> saveWantToWatchMovie(Movie movie);
  Future<({Failure? failure, bool? success})> saveWithGirlfriendMovie(Movie movie);
  Future<({Failure? failure, bool? success})> saveLikedMovie(Movie movie);
  Future<({Failure? failure, bool? success})> saveDislikedMovie(Movie movie);
  
  Future<({Failure? failure, bool? success})> removeWatchedMovie(int movieId);
  Future<({Failure? failure, bool? success})> removeWantToWatchMovie(int movieId);
  Future<({Failure? failure, bool? success})> removeWithGirlfriendMovie(int movieId);
  Future<({Failure? failure, bool? success})> removeLikedMovie(int movieId);
  Future<({Failure? failure, bool? success})> removeDislikedMovie(int movieId);
  
  Future<({Failure? failure, bool? success})> saveCustomMovie({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
  });
}

