class ApiConstants {
  // The Movie Database API
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '550e8400-e29b-41d4-a716-446655440000'; // Demo key - usar tu propia key
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageBaseUrlOriginal = 'https://image.tmdb.org/t/p/original';
  
  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String trendingMovies = '/trending/movie/week';
  static const String topRatedMovies = '/movie/top_rated';
  static const String movieDetails = '/movie';
  static const String searchMovies = '/search/movie';
  
  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Query parameters
  static Map<String, dynamic> get defaultParams => {
    'api_key': apiKey,
    'language': 'es-ES',
  };
}

