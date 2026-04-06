import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../core/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Theme Toggle
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Dark Mode',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                Switch(
                  value: isDark,
                  onChanged: (val) {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                  activeColor: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // App Info
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: theme.colorScheme.secondary),
                    const SizedBox(width: 16),
                    Text(
                      'App Information',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Version: 1.0.0', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 8),
                Text('Built with Flutter & Riverpod', style: theme.textTheme.bodyLarge),
                const SizedBox(height: 8),
                Text('Design by The Digital Curator', style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Logout Option (Placeholder)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: InkWell(
              onTap: () {
                // Logout logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout clicked (Placeholder)')),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.logout, color: theme.colorScheme.error),
                  const SizedBox(width: 16),
                  Text(
                    'Logout',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
