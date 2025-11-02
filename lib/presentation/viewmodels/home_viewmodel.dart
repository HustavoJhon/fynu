import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_trending_movies.dart';
import '../../core/errors/failures.dart';

enum HomeState { initial, loading, loaded, error }

class HomeViewModel extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;
  final GetTrendingMovies getTrendingMovies;
  
  HomeViewModel({
    required this.getPopularMovies,
    required this.getTrendingMovies,
  });
  
  HomeState _state = HomeState.initial;
  List<Movie> _popularMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _allMovies = [];
  String? _errorMessage;
  String _selectedCategory = 'Todas';
  
  HomeState get state => _state;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get allMovies => _allMovies;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  
  List<Movie> get filteredMovies {
    if (_selectedCategory == 'Todas') {
      return _allMovies;
    } else if (_selectedCategory == 'Populares') {
      return _popularMovies;
    } else if (_selectedCategory == 'Tendencias') {
      return _trendingMovies;
    }
    return _allMovies;
  }
  
  Future<void> loadMovies() async {
    _state = HomeState.loading;
    _errorMessage = null;
    notifyListeners();
    
    try {
      // Cargar películas populares
      final popularResult = await getPopularMovies();
      if (popularResult.failure != null) {
        _errorMessage = popularResult.failure!.message;
        _state = HomeState.error;
        notifyListeners();
        return;
      }
      _popularMovies = popularResult.movies ?? [];
      
      // Cargar películas en tendencia
      final trendingResult = await getTrendingMovies();
      if (trendingResult.failure != null) {
        _errorMessage = trendingResult.failure!.message;
        _state = HomeState.error;
        notifyListeners();
        return;
      }
      _trendingMovies = trendingResult.movies ?? [];
      
      // Combinar todas las películas
      final Set<int> seenIds = {};
      _allMovies = [];
      for (var movie in [..._popularMovies, ..._trendingMovies]) {
        if (!seenIds.contains(movie.id)) {
          _allMovies.add(movie);
          seenIds.add(movie.id);
        }
      }
      
      _state = HomeState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error inesperado: $e';
      _state = HomeState.error;
      notifyListeners();
    }
  }
  
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

