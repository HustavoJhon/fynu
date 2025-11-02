import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/movie_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failures.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getWatchedMovies();
  Future<List<MovieModel>> getWantToWatchMovies();
  Future<List<MovieModel>> getWithGirlfriendMovies();
  Future<List<MovieModel>> getLikedMovies();
  Future<List<MovieModel>> getDislikedMovies();
  
  Future<void> saveWatchedMovie(MovieModel movie);
  Future<void> saveWantToWatchMovie(MovieModel movie);
  Future<void> saveWithGirlfriendMovie(MovieModel movie);
  Future<void> saveLikedMovie(MovieModel movie);
  Future<void> saveDislikedMovie(MovieModel movie);
  
  Future<void> removeWatchedMovie(int movieId);
  Future<void> removeWantToWatchMovie(int movieId);
  Future<void> removeWithGirlfriendMovie(int movieId);
  Future<void> removeLikedMovie(int movieId);
  Future<void> removeDislikedMovie(int movieId);
  
  Future<void> saveCustomMovie({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
  });
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  MovieLocalDataSourceImpl(this.sharedPreferences);
  
  List<MovieModel> _getMoviesFromStorage(String key) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
  
  Future<void> _saveMoviesToStorage(String key, List<MovieModel> movies) async {
    final jsonList = movies.map((movie) => movie.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(key, jsonString);
  }
  
  Future<void> _addMovieToStorage(String key, MovieModel movie) async {
    final movies = _getMoviesFromStorage(key);
    if (movies.any((m) => m.id == movie.id)) return; // Ya existe
    movies.add(movie);
    await _saveMoviesToStorage(key, movies);
  }
  
  Future<void> _removeMovieFromStorage(String key, int movieId) async {
    final movies = _getMoviesFromStorage(key);
    movies.removeWhere((m) => m.id == movieId);
    await _saveMoviesToStorage(key, movies);
  }
  
  @override
  Future<List<MovieModel>> getWatchedMovies() async {
    return _getMoviesFromStorage(AppConstants.storageWatchedMovies);
  }
  
  @override
  Future<List<MovieModel>> getWantToWatchMovies() async {
    return _getMoviesFromStorage(AppConstants.storageWantToWatchMovies);
  }
  
  @override
  Future<List<MovieModel>> getWithGirlfriendMovies() async {
    return _getMoviesFromStorage(AppConstants.storageWithGirlfriendMovies);
  }
  
  @override
  Future<List<MovieModel>> getLikedMovies() async {
    return _getMoviesFromStorage(AppConstants.storageLikedMovies);
  }
  
  @override
  Future<List<MovieModel>> getDislikedMovies() async {
    return _getMoviesFromStorage(AppConstants.storageDislikedMovies);
  }
  
  @override
  Future<void> saveWatchedMovie(MovieModel movie) async {
    await _addMovieToStorage(AppConstants.storageWatchedMovies, movie);
  }
  
  @override
  Future<void> saveWantToWatchMovie(MovieModel movie) async {
    await _addMovieToStorage(AppConstants.storageWantToWatchMovies, movie);
  }
  
  @override
  Future<void> saveWithGirlfriendMovie(MovieModel movie) async {
    await _addMovieToStorage(AppConstants.storageWithGirlfriendMovies, movie);
  }
  
  @override
  Future<void> saveLikedMovie(MovieModel movie) async {
    await _addMovieToStorage(AppConstants.storageLikedMovies, movie);
  }
  
  @override
  Future<void> saveDislikedMovie(MovieModel movie) async {
    await _addMovieToStorage(AppConstants.storageDislikedMovies, movie);
  }
  
  @override
  Future<void> removeWatchedMovie(int movieId) async {
    await _removeMovieFromStorage(AppConstants.storageWatchedMovies, movieId);
  }
  
  @override
  Future<void> removeWantToWatchMovie(int movieId) async {
    await _removeMovieFromStorage(AppConstants.storageWantToWatchMovies, movieId);
  }
  
  @override
  Future<void> removeWithGirlfriendMovie(int movieId) async {
    await _removeMovieFromStorage(AppConstants.storageWithGirlfriendMovies, movieId);
  }
  
  @override
  Future<void> removeLikedMovie(int movieId) async {
    await _removeMovieFromStorage(AppConstants.storageLikedMovies, movieId);
  }
  
  @override
  Future<void> removeDislikedMovie(int movieId) async {
    await _removeMovieFromStorage(AppConstants.storageDislikedMovies, movieId);
  }
  
  @override
  Future<void> saveCustomMovie({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
  }) async {
    final customMovie = MovieModel(
      id: DateTime.now().millisecondsSinceEpoch, // ID único temporal
      title: title,
      overview: description,
      posterPath: imageUrl,
      backdropPath: imageUrl,
    );
    
    // Guardar en la categoría correspondiente
    if (category == 'Quiero ver') {
      await saveWantToWatchMovie(customMovie);
    } else if (category == 'Me gustó') {
      await saveLikedMovie(customMovie);
    }
  }
}

