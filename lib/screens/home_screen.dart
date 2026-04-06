import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MovieBox',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSection(context, ref, 'Featured Movies', featuredMoviesProvider),
            const SizedBox(height: 24),
            _buildSection(context, ref, 'Popular Now', popularMoviesProvider),
            const SizedBox(height: 24),
            _buildSection(context, ref, 'Latest Hits', latestMoviesProvider),
            const SizedBox(height: 24),
            _buildSection(context, ref, 'TV Series', seriesProvider),
            const SizedBox(height: 100), // Padding for bottom navbar
          ],
        ),
      ),
    );
  }
  // Helper method to build each movie section

  Widget _buildSection(
    BuildContext context, 
    WidgetRef ref, 
    String title, 
    FutureProvider<List<Movie>> provider,
  ) {
    final theme = Theme.of(context);
    final asyncValue = ref.watch(provider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: theme.textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 310, // allocate enough space to avoid overflow
          child: asyncValue.when(
            data: (movies) {
              if (movies.isEmpty) {
                return const Center(child: Text("No movies found."));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: movies[index]);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }
}
