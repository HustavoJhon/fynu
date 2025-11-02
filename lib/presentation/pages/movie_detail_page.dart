import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodels/movie_detail_viewmodel.dart';
import '../widgets/movie_action_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../../core/utils/network_utils.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/dependency_injection.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  
  const MovieDetailPage({
    super.key,
    required this.movieId,
  });
  
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late final MovieDetailViewModel _viewModel;
  
  @override
  void initState() {
    super.initState();
    _viewModel = sl<MovieDetailViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.loadMovieDetails(widget.movieId);
    });
  }
  
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  
  Future<void> _handleAction(String action) async {
    final viewModel = context.read<MovieDetailViewModel>();
    final movie = viewModel.movieDetail?.movie;
    
    if (movie == null) return;
    
    final success = await viewModel.saveMovieAction(movie, action);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success 
                ? 'Película guardada correctamente'
                : 'Error al guardar la película',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: Consumer<MovieDetailViewModel>(
          builder: (context, viewModel, child) {
          if (viewModel.state == MovieDetailState.loading) {
            return const LoadingWidget(message: 'Cargando detalles...');
          }
          
          if (viewModel.state == MovieDetailState.error) {
            return ErrorDisplayWidget(
              message: viewModel.errorMessage ?? 'Error desconocido',
              onRetry: () => viewModel.loadMovieDetails(widget.movieId),
            );
          }
          
          final movieDetail = viewModel.movieDetail;
          if (movieDetail == null) {
            return const Center(
              child: Text(
                'No se encontraron detalles',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
          
          final movie = movieDetail.movie;
          
          return CustomScrollView(
            slivers: [
              // AppBar con imagen de fondo
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: const Color(0xFF141414),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: NetworkUtils.getBackdropUrl(movie.backdropPath),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              
              // Contenido
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título y rating
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    if (movie.releaseDate != null) ...[
                                      Text(
                                        DateFormatter.formatYear(movie.releaseDate),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (movieDetail.runtime != null) ...[
                                        const Text(
                                          ' • ',
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                        Text(
                                          '${movieDetail.runtime} min',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (movie.voteAverage != null) ...[
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.voteAverage!.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Botones de acción
                      Row(
                        children: [
                          MovieActionButton(
                            icon: Icons.star,
                            label: 'Visto y me gustó',
                            onTap: () => _handleAction(AppConstants.actionLiked),
                          ),
                          const SizedBox(width: 8),
                          MovieActionButton(
                            icon: Icons.favorite,
                            label: 'Para ver con mi novia',
                            onTap: () => _handleAction(AppConstants.actionWithGirlfriend),
                          ),
                          const SizedBox(width: 8),
                          MovieActionButton(
                            icon: Icons.visibility,
                            label: 'Para ver más tarde',
                            onTap: () => _handleAction(AppConstants.actionWantToWatch),
                          ),
                          const SizedBox(width: 8),
                          MovieActionButton(
                            icon: Icons.thumb_down,
                            label: 'No me gustó',
                            onTap: () => _handleAction(AppConstants.actionDisliked),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sinopsis
                      const Text(
                        'Sinopsis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview ?? 'Sin descripción disponible',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      
                      if (movieDetail.genres != null && movieDetail.genres!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Géneros',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: movieDetail.genres!.map((genre) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }
}

