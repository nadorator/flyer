import 'package:flutter/material.dart';

/// Page placeholder commune aux features non encore implémentées.
///
/// Affiche le titre, l'epic / sprint concerné et une description courte, afin
/// que chaque route du squelette soit navigable dès le Sprint 0.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    required this.description,
    required this.sprint,
    this.icon = Icons.construction_outlined,
    this.actions = const [],
  });

  final String title;
  final String description;
  final String sprint;
  final IconData icon;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 72, color: theme.colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                title,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Chip(label: Text('Prévu : $sprint')),
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 24),
                Wrap(spacing: 12, runSpacing: 12, children: actions),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
