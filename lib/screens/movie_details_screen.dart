import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_provider.dart';
import '../providers/favorites_provider.dart';
import '../models/movie.dart';
import '../widgets/curator_chip.dart';
import '../widgets/skeleton_loader.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final String imdbID;

  const MovieDetailsScreen({
    super.key,
    required this.imdbID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final movieAsync = ref.watch(movieDetailsProvider(imdbID));

    return Scaffold(
      body: movieAsync.when(
        data: (movie) {
          final isFavorite = ref.watch(favoritesProvider.notifier).isFavorite(imdbID);
          ref.watch(favoritesProvider); // Rebuild on favorite toggle

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                backgroundColor: theme.colorScheme.surface,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Backdrop (Cinematic bleed)
                      movie.poster.isNotEmpty && movie.poster != 'N/A'
                          ? CachedNetworkImage(
                              imageUrl: movie.poster,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, err) => Container(color: Colors.black),
                            )
                          : Container(color: Colors.black),
                      // Gradient overlay for bottom-up black gradient
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              theme.colorScheme.surface,
                              theme.colorScheme.surface.withOpacity(0.0),
                            ],
                            stops: const [0.0, 0.7],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sharing coming soon...')),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: isFavorite ? theme.colorScheme.primary : null,
                    onPressed: () {
                      final simplifiedMovie = movie.toMovieJson();
                      ref.read(favoritesProvider.notifier).toggleFavorite(Movie.fromJson(simplifiedMovie));
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        movie.title,
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 40,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Meta info
                      Text(
                        '${movie.year} • ${movie.rated} • ${movie.runtime}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Genres
                      Wrap(
                        children: movie.genre
                            .split(', ')
                            .map((g) => CuratorChip(label: g))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      // IMDb Rating
                      Row(
                        children: [
                          Icon(Icons.star, color: theme.colorScheme.secondary, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            '${movie.imdbRating}/10',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${movie.imdbVotes} votes)',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Plot
                      Text(
                        'Synopsis',
                        style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.plot,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      // Cast
                      Text(
                        'Director',
                        style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.director,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Cast',
                        style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.actors,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      // Add to Favorites glassmorphism button
                      GestureDetector(
                        onTap: () {
                          // Create simplified movie object for favorites
                          final simplifiedMovie = movie.toMovieJson();
                          ref.read(favoritesProvider.notifier).toggleFavorite(
                            Movie.fromJson(simplifiedMovie),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                const Color(0xFFE50914), // explicitly use primary_container color
                              ],
                            ),
                            borderRadius: BorderRadius.circular(999), // full rounded
                          ),
                          child: Center(
                            child: Text(
                              isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: SkeletonLoader(width: 100, height: 100, borderRadius: 50)),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
