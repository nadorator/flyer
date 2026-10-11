import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Génération IA des flyers et textes (FL-301 → FL-305) — Sprint 2.
///
/// Appelle l'Edge Function `generate-content` ; le client n'accède jamais
/// directement aux API IA.
class FlyerGeneratorPage extends StatelessWidget {
  const FlyerGeneratorPage({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Génération IA',
      icon: Icons.auto_awesome_outlined,
      description:
          '3 propositions de texte par plateforme et des visuels (carré, '
          'story, A4) à vos couleurs, à éditer puis partager en un geste.',
      sprint: 'Sprint 2 · FL-301 → FL-305',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.events),
          child: const Text('Retour aux events'),
        ),
        FilledButton.tonal(
          onPressed: () => context.go(AppRoutes.eventNeedsPath(eventId)),
          child: const Text('Besoins par plateforme'),
        ),
      ],
    );
  }
}
