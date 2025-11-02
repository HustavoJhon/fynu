import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/movie_local_datasource.dart';
import '../models/movie_model.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final MovieLocalDataSource localDataSource;
  
  LocalStorageRepositoryImpl(this.localDataSource);
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getWatchedMovies() async {
    try {
      final movies = await localDataSource.getWatchedMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return (failure: CacheFailure('Error al obtener películas vistas: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getWantToWatchMovies() async {
    try {
      final movies = await localDataSource.getWantToWatchMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return (failure: CacheFailure('Error al obtener películas por ver: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getWithGirlfriendMovies() async {
    try {
      final movies = await localDataSource.getWithGirlfriendMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return (failure: CacheFailure('Error al obtener películas con novia: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getLikedMovies() async {
    try {
      final movies = await localDataSource.getLikedMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return (failure: CacheFailure('Error al obtener películas que me gustaron: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getDislikedMovies() async {
    try {
      final movies = await localDataSource.getDislikedMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } catch (e) {
      return (failure: CacheFailure('Error al obtener películas no me gustaron: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveWatchedMovie(Movie movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        isAdult: movie.isAdult,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        genreIds: movie.genreIds,
        popularity: movie.popularity,
      );
      await localDataSource.saveWatchedMovie(movieModel);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película vista: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveWantToWatchMovie(Movie movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        isAdult: movie.isAdult,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        genreIds: movie.genreIds,
        popularity: movie.popularity,
      );
      await localDataSource.saveWantToWatchMovie(movieModel);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película por ver: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveWithGirlfriendMovie(Movie movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        isAdult: movie.isAdult,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        genreIds: movie.genreIds,
        popularity: movie.popularity,
      );
      await localDataSource.saveWithGirlfriendMovie(movieModel);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película con novia: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveLikedMovie(Movie movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        isAdult: movie.isAdult,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        genreIds: movie.genreIds,
        popularity: movie.popularity,
      );
      await localDataSource.saveLikedMovie(movieModel);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película que me gustó: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveDislikedMovie(Movie movie) async {
    try {
      final movieModel = MovieModel(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        backdropPath: movie.backdropPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        isAdult: movie.isAdult,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        genreIds: movie.genreIds,
        popularity: movie.popularity,
      );
      await localDataSource.saveDislikedMovie(movieModel);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película que no me gustó: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> removeWatchedMovie(int movieId) async {
    try {
      await localDataSource.removeWatchedMovie(movieId);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al eliminar película vista: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> removeWantToWatchMovie(int movieId) async {
    try {
      await localDataSource.removeWantToWatchMovie(movieId);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al eliminar película por ver: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> removeWithGirlfriendMovie(int movieId) async {
    try {
      await localDataSource.removeWithGirlfriendMovie(movieId);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al eliminar película con novia: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> removeLikedMovie(int movieId) async {
    try {
      await localDataSource.removeLikedMovie(movieId);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al eliminar película que me gustó: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> removeDislikedMovie(int movieId) async {
    try {
      await localDataSource.removeDislikedMovie(movieId);
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al eliminar película que no me gustó: $e'), success: false);
    }
  }
  
  @override
  Future<({Failure? failure, bool? success})> saveCustomMovie({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
  }) async {
    try {
      await localDataSource.saveCustomMovie(
        title: title,
        description: description,
        imageUrl: imageUrl,
        category: category,
      );
      return (failure: null, success: true);
    } catch (e) {
      return (failure: CacheFailure('Error al guardar película personalizada: $e'), success: false);
    }
  }
}

