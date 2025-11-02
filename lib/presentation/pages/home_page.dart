import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_grid.dart';
import '../widgets/category_chip.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../../core/constants/app_constants.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadMovies();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        elevation: 0,
        title: const Text(
          'Fynu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == HomeState.loading) {
            return const LoadingWidget(message: 'Cargando películas...');
          }
          
          if (viewModel.state == HomeState.error) {
            return ErrorDisplayWidget(
              message: viewModel.errorMessage ?? 'Error desconocido',
              onRetry: () => viewModel.loadMovies(),
            );
          }
          
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categorías
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryChip(
                          label: AppConstants.categoryAll,
                          isSelected: viewModel.selectedCategory == AppConstants.categoryAll,
                          onTap: () => viewModel.selectCategory(AppConstants.categoryAll),
                        ),
                        CategoryChip(
                          label: AppConstants.categoryPopular,
                          isSelected: viewModel.selectedCategory == AppConstants.categoryPopular,
                          onTap: () => viewModel.selectCategory(AppConstants.categoryPopular),
                        ),
                        CategoryChip(
                          label: AppConstants.categoryTrending,
                          isSelected: viewModel.selectedCategory == AppConstants.categoryTrending,
                          onTap: () => viewModel.selectCategory(AppConstants.categoryTrending),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Carrusel de películas populares (si está seleccionado "Todas" o "Populares")
                if (viewModel.selectedCategory == AppConstants.categoryAll ||
                    viewModel.selectedCategory == AppConstants.categoryPopular) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Populares',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: viewModel.popularMovies.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.popularMovies[index];
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(movieId: movie.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Carrusel de películas en tendencia (si está seleccionado "Todas" o "Tendencias")
                if (viewModel.selectedCategory == AppConstants.categoryAll ||
                    viewModel.selectedCategory == AppConstants.categoryTrending) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Tendencias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: viewModel.trendingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = viewModel.trendingMovies[index];
                        return MovieCard(
                          movie: movie,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(movieId: movie.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Grid de todas las películas (si está seleccionado "Todas")
                if (viewModel.selectedCategory == AppConstants.categoryAll) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Todas las películas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5,
                    child: MovieGrid(
                      movies: viewModel.filteredMovies,
                      onMovieTap: (movie) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(movieId: movie.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                
                // Grid de películas filtradas (si no es "Todas")
                if (viewModel.selectedCategory != AppConstants.categoryAll) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: MovieGrid(
                      movies: viewModel.filteredMovies,
                      onMovieTap: (movie) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(movieId: movie.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

