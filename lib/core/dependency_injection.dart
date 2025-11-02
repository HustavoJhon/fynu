import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/network_utils.dart';
import '../data/datasources/movie_remote_datasource.dart';
import '../data/datasources/movie_local_datasource.dart';
import '../data/repositories_impl/movie_repository_impl.dart';
import '../data/repositories_impl/local_storage_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/repositories/local_storage_repository.dart';
import '../domain/usecases/get_popular_movies.dart';
import '../domain/usecases/get_trending_movies.dart';
import '../domain/usecases/get_movie_details.dart';
import '../domain/usecases/search_movies.dart';
import '../presentation/viewmodels/home_viewmodel.dart';
import '../presentation/viewmodels/movie_detail_viewmodel.dart';
import '../presentation/viewmodels/collection_viewmodel.dart';
import '../presentation/viewmodels/girlfriend_viewmodel.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  final dio = NetworkUtils.createDioClient();
  sl.registerLazySingleton<Dio>(() => dio);
  
  // Data Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl<Dio>()),
  );
  
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(sl<SharedPreferences>()),
  );
  
  // Repositories
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl<MovieRemoteDataSource>()),
  );
  
  sl.registerLazySingleton<LocalStorageRepository>(
    () => LocalStorageRepositoryImpl(sl<MovieLocalDataSource>()),
  );
  
  // Use Cases
  sl.registerLazySingleton(() => GetPopularMovies(sl<MovieRepository>()));
  sl.registerLazySingleton(() => GetTrendingMovies(sl<MovieRepository>()));
  sl.registerLazySingleton(() => GetMovieDetails(sl<MovieRepository>()));
  sl.registerLazySingleton(() => SearchMovies(sl<MovieRepository>()));
  
  // ViewModels (se registran como factory para que se creen nuevas instancias)
  sl.registerFactory(
    () => HomeViewModel(
      getPopularMovies: sl<GetPopularMovies>(),
      getTrendingMovies: sl<GetTrendingMovies>(),
    ),
  );
  
  sl.registerFactory(
    () => MovieDetailViewModel(
      getMovieDetails: sl<GetMovieDetails>(),
      localStorageRepository: sl<LocalStorageRepository>(),
    ),
  );
  
  sl.registerFactory(
    () => CollectionViewModel(
      localStorageRepository: sl<LocalStorageRepository>(),
    ),
  );
  
  sl.registerFactory(
    () => GirlfriendViewModel(
      localStorageRepository: sl<LocalStorageRepository>(),
    ),
  );
}
