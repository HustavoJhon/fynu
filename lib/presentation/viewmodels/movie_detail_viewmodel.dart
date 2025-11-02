import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../core/errors/failures.dart';

enum MovieDetailState { initial, loading, loaded, error }

class MovieDetailViewModel extends ChangeNotifier {
  final GetMovieDetails getMovieDetails;
  final LocalStorageRepository localStorageRepository;
  
  MovieDetailViewModel({
    required this.getMovieDetails,
    required this.localStorageRepository,
  });
  
  MovieDetailState _state = MovieDetailState.initial;
  MovieDetail? _movieDetail;
  String? _errorMessage;
  bool _isSaving = false;
  
  MovieDetailState get state => _state;
  MovieDetail? get movieDetail => _movieDetail;
  String? get errorMessage => _errorMessage;
  bool get isSaving => _isSaving;
  
  Future<void> loadMovieDetails(int movieId) async {
    _state = MovieDetailState.loading;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final result = await getMovieDetails(movieId);
      if (result.failure != null) {
        _errorMessage = result.failure!.message;
        _state = MovieDetailState.error;
        notifyListeners();
        return;
      }
      
      _movieDetail = result.movie;
      _state = MovieDetailState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error inesperado: $e';
      _state = MovieDetailState.error;
      notifyListeners();
    }
  }
  
  Future<bool> saveMovieAction(Movie movie, String action) async {
    _isSaving = true;
    notifyListeners();
    
    try {
      final result = switch (action) {
        'watched' => await localStorageRepository.saveWatchedMovie(movie),
        'want_to_watch' => await localStorageRepository.saveWantToWatchMovie(movie),
        'with_girlfriend' => await localStorageRepository.saveWithGirlfriendMovie(movie),
        'liked' => await localStorageRepository.saveLikedMovie(movie),
        'disliked' => await localStorageRepository.saveDislikedMovie(movie),
        _ => (failure: UnknownFailure('Acción desconocida'), success: false),
      };
      
      _isSaving = false;
      notifyListeners();
      
      return result.success ?? false;
    } catch (e) {
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }
}

