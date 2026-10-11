import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Liste des clients (FL-601 → FL-604) — Sprint 5.
class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Clients',
      icon: Icons.people_outline,
      description:
          'Fiches clients et animaux, tags, historique d\'events, '
          'consentement RGPD, import / export CSV, puis synchronisation '
          'Salesforce et Odoo (plan Studio).',
      sprint: 'Sprint 5 · FL-601 → FL-604 (Sprint 7 · FL-605 / FL-606)',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.events),
          child: const Text('Mes events'),
        ),
        FilledButton.tonalIcon(
          onPressed: null,
          icon: const Icon(Icons.upload_file_outlined),
          label: const Text('Importer un CSV (S5)'),
        ),
      ],
    );
  }
}
