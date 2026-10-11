import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Formulaire d'event (FL-201) — placeholder, implémentation en Sprint 1.
///
/// `eventId` est `null` pour une création, renseigné pour une édition.
class EventFormPage extends StatelessWidget {
  const EventFormPage({super.key, this.eventId});

  final String? eventId;

  @override
  Widget build(BuildContext context) {
    final isEdit = eventId != null;
    return PlaceholderPage(
      title: isEdit ? 'Modifier l\'event' : 'Nouvel event',
      icon: Icons.event_outlined,
      description:
          'Nom, description, plage de dates, horaires par jour, lieu, '
          'enseigne partenaire, tarif et lien de réservation. Validation : '
          'date de fin ≥ date de début, horaires cohérents, brouillon '
          'sauvegardé automatiquement.',
      sprint: 'Sprint 1 · FL-201 / FL-203',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.events),
          child: const Text('Retour'),
        ),
      ],
    );
  }
}
