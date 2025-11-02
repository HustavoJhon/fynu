import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../core/errors/failures.dart';

enum CollectionState { initial, loading, loaded, error }

class CollectionViewModel extends ChangeNotifier {
  final LocalStorageRepository localStorageRepository;
  
  CollectionViewModel({
    required this.localStorageRepository,
  });
  
  CollectionState _state = CollectionState.initial;
  List<Movie> _wantToWatchMovies = [];
  List<Movie> _likedMovies = [];
  String? _errorMessage;
  
  CollectionState get state => _state;
  List<Movie> get wantToWatchMovies => _wantToWatchMovies;
  List<Movie> get likedMovies => _likedMovies;
  String? get errorMessage => _errorMessage;
  
  Future<void> loadMovies() async {
    _state = CollectionState.loading;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final wantToWatchResult = await localStorageRepository.getWantToWatchMovies();
      if (wantToWatchResult.failure != null) {
        _errorMessage = wantToWatchResult.failure!.message;
        _state = CollectionState.error;
        notifyListeners();
        return;
      }
      _wantToWatchMovies = wantToWatchResult.movies ?? [];
      
      final likedResult = await localStorageRepository.getLikedMovies();
      if (likedResult.failure != null) {
        _errorMessage = likedResult.failure!.message;
        _state = CollectionState.error;
        notifyListeners();
        return;
      }
      _likedMovies = likedResult.movies ?? [];
      
      _state = CollectionState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error inesperado: $e';
      _state = CollectionState.error;
      notifyListeners();
    }
  }
  
  Future<bool> saveCustomMovie({
    required String title,
    required String description,
    required String imageUrl,
    required String category,
  }) async {
    try {
      final result = await localStorageRepository.saveCustomMovie(
        title: title,
        description: description,
        imageUrl: imageUrl,
        category: category,
      );
      
      if (result.success == true) {
        await loadMovies();
      }
      
      return result.success ?? false;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> removeMovie(int movieId, String category) async {
    try {
      final result = category == 'Quiero ver'
          ? await localStorageRepository.removeWantToWatchMovie(movieId)
          : await localStorageRepository.removeLikedMovie(movieId);
      
      if (result.success == true) {
        await loadMovies();
      }
      
      return result.success ?? false;
    } catch (e) {
      return false;
    }
  }
}

