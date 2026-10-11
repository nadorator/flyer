import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme.dart';
import '../../auth/presentation/auth_providers.dart';

/// Liste des events (FL-202) — écran d'accueil après connexion.
///
/// Placeholder navigable : expose les raccourcis vers toutes les features du
/// squelette pour les tests de navigation du Sprint 0.
class EventListPage extends ConsumerWidget {
  const EventListPage({super.key});

  static const _demoEventId = 'demo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes events'),
        actions: [
          IconButton(
            tooltip: 'Profil entreprise',
            icon: const Icon(Icons.storefront_outlined),
            onPressed: () => context.go(AppRoutes.businessProfile),
          ),
          IconButton(
            tooltip: 'Clients',
            icon: const Icon(Icons.people_outline),
            onPressed: () => context.go(AppRoutes.customers),
          ),
          IconButton(
            tooltip: 'Se déconnecter',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authStateProvider.notifier).signOut(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(FlyerSpacing.md),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(FlyerSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aucun event pour l\'instant',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: FlyerSpacing.sm),
                  const Text(
                    'Créez votre premier event en moins de 5 minutes : dates, '
                    'horaires, lieu, enseigne partenaire, tarif et lien de '
                    'réservation.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: FlyerSpacing.lg),
          Text('Parcours du squelette', style: theme.textTheme.titleSmall),
          const SizedBox(height: FlyerSpacing.sm),
          _NavTile(
            icon: Icons.auto_awesome_outlined,
            title: 'Génération IA',
            subtitle: 'Sprint 2 · FL-301',
            onTap: () =>
                context.go(AppRoutes.eventGeneratePath(_demoEventId)),
          ),
          _NavTile(
            icon: Icons.checklist_outlined,
            title: 'Besoins par plateforme',
            subtitle: 'Sprint 3 · FL-401',
            onTap: () => context.go(AppRoutes.eventNeedsPath(_demoEventId)),
          ),
          _NavTile(
            icon: Icons.handshake_outlined,
            title: 'Kit partenaire',
            subtitle: 'Sprint 3 · FL-501',
            onTap: () =>
                context.go(AppRoutes.eventPartnerKitPath(_demoEventId)),
          ),
          _NavTile(
            icon: Icons.workspace_premium_outlined,
            title: 'Plans & abonnement',
            subtitle: 'Sprint 6 · FL-702',
            onTap: () => context.go(AppRoutes.paywall),
          ),
          _NavTile(
            icon: Icons.card_giftcard_outlined,
            title: 'Code partenaire',
            subtitle: 'Sprint 6 · FL-704',
            onTap: () => context.go(AppRoutes.partnerCode),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.eventNew),
        icon: const Icon(Icons.add),
        label: const Text('Nouvel event'),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
