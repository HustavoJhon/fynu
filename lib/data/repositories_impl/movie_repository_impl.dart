import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/movie_remote_datasource.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  
  MovieRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getPopularMovies() async {
    try {
      final movies = await remoteDataSource.getPopularMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } on Failure catch (failure) {
      return (failure: failure, movies: null);
    } catch (e) {
      return (failure: UnknownFailure('Error desconocido: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getTrendingMovies() async {
    try {
      final movies = await remoteDataSource.getTrendingMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } on Failure catch (failure) {
      return (failure: failure, movies: null);
    } catch (e) {
      return (failure: UnknownFailure('Error desconocido: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> getTopRatedMovies() async {
    try {
      final movies = await remoteDataSource.getTopRatedMovies();
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } on Failure catch (failure) {
      return (failure: failure, movies: null);
    } catch (e) {
      return (failure: UnknownFailure('Error desconocido: $e'), movies: null);
    }
  }
  
  @override
  Future<({Failure? failure, MovieDetail? movie})> getMovieDetails(int movieId) async {
    try {
      final movieDetail = await remoteDataSource.getMovieDetails(movieId);
      return (failure: null, movie: movieDetail.toEntity());
    } on Failure catch (failure) {
      return (failure: failure, movie: null);
    } catch (e) {
      return (failure: UnknownFailure('Error desconocido: $e'), movie: null);
    }
  }
  
  @override
  Future<({Failure? failure, List<Movie>? movies})> searchMovies(String query) async {
    try {
      final movies = await remoteDataSource.searchMovies(query);
      return (failure: null, movies: movies.map((m) => m.toEntity()).toList());
    } on Failure catch (failure) {
      return (failure: failure, movies: null);
    } catch (e) {
      return (failure: UnknownFailure('Error desconocido: $e'), movies: null);
    }
  }
}

