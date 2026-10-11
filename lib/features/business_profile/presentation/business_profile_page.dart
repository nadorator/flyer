import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Profil entreprise (FL-102) — placeholder, implémentation en Sprint 1.
class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Profil entreprise',
      icon: Icons.storefront_outlined,
      description:
          'Nom commercial, SIRET, logo, adresse, téléphone, site, réseaux '
          'sociaux et couleurs : tout ce qui alimente vos flyers.',
      sprint: 'Sprint 1 · FL-102',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.events),
          child: const Text('Mes events'),
        ),
      ],
    );
  }
}
