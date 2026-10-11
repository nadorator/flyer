import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme.dart';
import '../domain/plan.dart';

/// Paywall (FL-701 → FL-703) — Sprint 6. Placeholder affichant les plans.
class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans & abonnement'),
        leading: BackButton(onPressed: () => context.go(AppRoutes.events)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(FlyerSpacing.md),
        children: [
          const Text(
            'Achats in-app via RevenueCat, quotas appliqués côté serveur. '
            'Sprint 6 · FL-701 → FL-703.',
          ),
          const SizedBox(height: FlyerSpacing.md),
          for (final plan in [Plan.free, Plan.pro, Plan.studio])
            Card(
              child: ListTile(
                title: Text(plan.label, style: theme.textTheme.titleMedium),
                subtitle: Text(_describe(plan.quotas)),
                trailing: Text(
                  plan.monthlyPrice == 0
                      ? '0 €'
                      : '${plan.monthlyPrice.toStringAsFixed(0)} €/mois',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
          const SizedBox(height: FlyerSpacing.md),
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.partnerCode),
            icon: const Icon(Icons.card_giftcard_outlined),
            label: const Text('J\'ai un code partenaire'),
          ),
        ],
      ),
    );
  }

  static String _describe(PlanQuotas q) {
    String fmt(int? v) => v == null ? 'illimité' : '$v';
    return 'Events/mois : ${fmt(q.eventsPerMonth)} · IA/mois : '
        '${fmt(q.aiGenerationsPerMonth)} · Plateformes : '
        '${fmt(q.connectedPlatforms)} · Contacts : ${fmt(q.contacts)}'
        '${q.watermark ? ' · watermark' : ''}'
        '${q.crmSync ? ' · Salesforce/Odoo' : ''}';
  }
}
