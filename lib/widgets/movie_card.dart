import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/favorites_provider.dart';
import '../screens/movie_details_screen.dart';
import '../core/theme/app_theme.dart';
import 'skeleton_loader.dart';

class MovieCard extends ConsumerWidget {
  final Movie movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 160,
    this.height = 240,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isFavorite = ref.watch(favoritesProvider.notifier).isFavorite(movie.imdbID);
    // Observe favorites list to trigger rebuild
    ref.watch(favoritesProvider); 

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(imdbID: movie.imdbID),
          ),
        );
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster with Favorite Button
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    child: movie.poster.isNotEmpty && movie.poster != 'N/A'
                        ? CachedNetworkImage(
                            imageUrl: movie.poster,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const SkeletonLoader(
                                width: double.infinity, height: double.infinity, borderRadius: AppTheme.radiusXl),
                            errorWidget: (context, url, error) => _buildErrorPoster(),
                          )
                        : _buildErrorPoster(),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(favoritesProvider.notifier).toggleFavorite(movie);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withOpacity(0.6),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            // Year & Type
            Text(
              '${movie.year} • ${movie.type.toUpperCase()}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorPoster() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(Icons.movie, size: 40, color: Colors.white54),
      ),
    );
  }
}
