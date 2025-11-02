import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/girlfriend_viewmodel.dart';
import '../widgets/movie_grid.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import 'movie_detail_page.dart';

class GirlfriendPage extends StatefulWidget {
  const GirlfriendPage({super.key});
  
  @override
  State<GirlfriendPage> createState() => _GirlfriendPageState();
}

class _GirlfriendPageState extends State<GirlfriendPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GirlfriendViewModel>().loadMovies();
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
          'Con mi novia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<GirlfriendViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == GirlfriendState.loading) {
            return const LoadingWidget(message: 'Cargando películas...');
          }
          
          if (viewModel.state == GirlfriendState.error) {
            return ErrorDisplayWidget(
              message: viewModel.errorMessage ?? 'Error desconocido',
              onRetry: () => viewModel.loadMovies(),
            );
          }
          
          if (viewModel.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_outline,
                    color: Colors.white38,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay películas para ver juntos',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Marca películas como "Para ver con mi novia" desde el detalle',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          
          return MovieGrid(
            movies: viewModel.movies,
            onMovieTap: (movie) {
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
    );
  }
}

