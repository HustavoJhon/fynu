import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/movie.dart';
import '../viewmodels/collection_viewmodel.dart';
import '../widgets/movie_grid.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import 'movie_detail_page.dart';
import 'add_custom_movie_page.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});
  
  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectionViewModel>().loadMovies();
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
          'Mi Colección',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCustomMoviePage(),
                ),
              ).then((_) {
                context.read<CollectionViewModel>().loadMovies();
              });
            },
          ),
        ],
      ),
      body: Consumer<CollectionViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == CollectionState.loading) {
            return const LoadingWidget(message: 'Cargando colección...');
          }
          
          if (viewModel.state == CollectionState.error) {
            return ErrorDisplayWidget(
              message: viewModel.errorMessage ?? 'Error desconocido',
              onRetry: () => viewModel.loadMovies(),
            );
          }
          
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Color(0xFFE50914),
                  tabs: [
                    Tab(text: 'Quiero ver'),
                    Tab(text: 'Me gustó'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Películas que quiero ver
                      _buildMovieSection(
                        viewModel.wantToWatchMovies,
                        'Quiero ver',
                        viewModel,
                      ),
                      // Películas que me gustaron
                      _buildMovieSection(
                        viewModel.likedMovies,
                        'Me gustó',
                        viewModel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildMovieSection(
    List<dynamic> movies,
    String category,
    CollectionViewModel viewModel,
  ) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.movie_outlined,
              color: Colors.white38,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay películas en "$category"',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    
    return MovieGrid(
      movies: movies.cast<Movie>(),
      onMovieTap: (movie) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movieId: movie.id),
          ),
        );
      },
    );
  }
}

