import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Saisie d'un code partenaire (FL-704) — Sprint 6.
///
/// Appelle l'Edge Function `redeem-partner-code` ; le plan `partner` est
/// accordé côté serveur, sans paiement.
class PartnerCodePage extends StatelessWidget {
  const PartnerCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Code partenaire',
      icon: Icons.card_giftcard_outlined,
      description:
          'Saisissez votre code (ex. AMB-XXXX-2026) pour débloquer toutes les '
          'fonctionnalités gratuitement, en échange de vos retours.',
      sprint: 'Sprint 6 · FL-704',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.paywall),
          child: const Text('Voir les plans'),
        ),
      ],
    );
  }
}
