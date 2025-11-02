import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../core/errors/failures.dart';

enum GirlfriendState { initial, loading, loaded, error }

class GirlfriendViewModel extends ChangeNotifier {
  final LocalStorageRepository localStorageRepository;
  
  GirlfriendViewModel({
    required this.localStorageRepository,
  });
  
  GirlfriendState _state = GirlfriendState.initial;
  List<Movie> _movies = [];
  String? _errorMessage;
  
  GirlfriendState get state => _state;
  List<Movie> get movies => _movies;
  String? get errorMessage => _errorMessage;
  
  Future<void> loadMovies() async {
    _state = GirlfriendState.loading;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final result = await localStorageRepository.getWithGirlfriendMovies();
      if (result.failure != null) {
        _errorMessage = result.failure!.message;
        _state = GirlfriendState.error;
        notifyListeners();
        return;
      }
      
      _movies = result.movies ?? [];
      _state = GirlfriendState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error inesperado: $e';
      _state = GirlfriendState.error;
      notifyListeners();
    }
  }
  
  Future<bool> removeMovie(int movieId) async {
    try {
      final result = await localStorageRepository.removeWithGirlfriendMovie(movieId);
      
      if (result.success == true) {
        await loadMovies();
      }
      
      return result.success ?? false;
    } catch (e) {
      return false;
    }
  }
}

