import 'package:dio/dio.dart';

class NetworkUtils {
  static String getImageUrl(String? path, {bool original = false}) {
    if (path == null || path.isEmpty) {
      return 'https://via.placeholder.com/500x750?text=No+Image';
    }
    
    final baseUrl = original 
        ? 'https://image.tmdb.org/t/p/original'
        : 'https://image.tmdb.org/t/p/w500';
    
    return baseUrl + path;
  }
  
  static String getBackdropUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://via.placeholder.com/1280x720?text=No+Image';
    }
    
    return 'https://image.tmdb.org/t/p/original' + path;
  }
  
  static Dio createDioClient() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Interceptor para agregar API key
    // IMPORTANTE: Obtén tu propia API key gratuita en https://www.themoviedb.org/settings/api
    // Reemplaza la siguiente key con la tuya
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Usa tu propia API key de TMDB aquí
        options.queryParameters['api_key'] = 'TU_API_KEY_AQUI';
        options.queryParameters['language'] = 'es-ES';
        return handler.next(options);
      },
    ));
    
    return dio;
  }
}

