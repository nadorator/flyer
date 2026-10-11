import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Kit partenaire (FL-501 / FL-502) — Sprint 3.
///
/// Lien public sans compte pour le magasin : affiche A4 PDF, post à copier,
/// image à télécharger, QR code vers la page publique, checklist de relais.
class PartnerKitPage extends StatelessWidget {
  const PartnerKitPage({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Kit partenaire',
      icon: Icons.handshake_outlined,
      description:
          'Envoyez au magasin un lien avec l\'affiche à imprimer, le post à '
          'copier et un QR code de réservation. Vous êtes notifié quand il '
          'est ouvert et quand la checklist est cochée.',
      sprint: 'Sprint 3 · FL-501 / FL-502',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.events),
          child: const Text('Retour aux events'),
        ),
        FilledButton.icon(
          onPressed: null,
          icon: const Icon(Icons.share_outlined),
          label: const Text('Envoyer le kit (S3)'),
        ),
      ],
    );
  }
}
