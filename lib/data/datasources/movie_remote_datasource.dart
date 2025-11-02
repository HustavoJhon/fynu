import 'package:dio/dio.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';
import '../../core/utils/network_utils.dart';
import '../../core/errors/failures.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;
  
  MovieRemoteDataSourceImpl(this.dio);
  
  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dio.get('/movie/popular');
      final results = response.data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerFailure('Error al obtener películas populares: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Error desconocido: $e');
    }
  }
  
  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await dio.get('/trending/movie/week');
      final results = response.data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerFailure('Error al obtener películas en tendencia: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Error desconocido: $e');
    }
  }
  
  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await dio.get('/movie/top_rated');
      final results = response.data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerFailure('Error al obtener películas mejor valoradas: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Error desconocido: $e');
    }
  }
  
  @override
  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get('/movie/$movieId');
      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure('Error al obtener detalles de la película: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Error desconocido: $e');
    }
  }
  
  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dio.get('/search/movie', queryParameters: {'query': query});
      final results = response.data['results'] as List;
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerFailure('Error al buscar películas: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Error desconocido: $e');
    }
  }
}

