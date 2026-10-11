import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme.dart';
import '../domain/platform_need.dart';

/// Matrice « plateforme × besoin » (FL-401 / FL-402) — Sprint 3.
///
/// Placeholder : affiche la matrice initiale (tout « manquant ») pour les
/// plateformes par défaut, en lecture seule.
class PlatformNeedsPage extends StatelessWidget {
  const PlatformNeedsPage({super.key, required this.eventId});

  final String eventId;

  static const _defaultPlatforms = [
    Platform.instagram,
    Platform.facebook,
    Platform.tiktok,
    Platform.localGroups,
    Platform.storePage,
    Platform.printA4,
  ];

  @override
  Widget build(BuildContext context) {
    final needs = PlatformNeed.initialMatrix(_defaultPlatforms);
    final byPlatform = <Platform, List<PlatformNeed>>{};
    for (final need in needs) {
      byPlatform.putIfAbsent(need.platform, () => []).add(need);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Besoins par plateforme'),
        leading: BackButton(onPressed: () => context.go(AppRoutes.events)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(FlyerSpacing.md),
        children: [
          const Text(
            'Pour chaque plateforme, voici ce qu\'il faut fournir ou générer. '
            'Sprint 3 · FL-401 / FL-402.',
          ),
          const SizedBox(height: FlyerSpacing.md),
          for (final entry in byPlatform.entries)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(FlyerSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: FlyerSpacing.sm),
                    Wrap(
                      spacing: FlyerSpacing.sm,
                      children: [
                        for (final need in entry.value)
                          _NeedChip(need: need),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.eventPartnerKitPath(eventId)),
        icon: const Icon(Icons.handshake_outlined),
        label: const Text('Kit partenaire'),
      ),
    );
  }
}

class _NeedChip extends StatelessWidget {
  const _NeedChip({required this.need});

  final PlatformNeed need;

  @override
  Widget build(BuildContext context) {
    final (icon, label) = switch (need.type) {
      NeedType.photo => (Icons.photo_outlined, 'Photo'),
      NeedType.video => (Icons.videocam_outlined, 'Vidéo'),
      NeedType.audio => (Icons.mic_none_outlined, 'Audio'),
      NeedType.text => (Icons.notes_outlined, 'Texte'),
    };
    final status = switch (need.status) {
      NeedStatus.missing => 'manquant',
      NeedStatus.provided => 'fourni',
      NeedStatus.generated => 'généré',
    };
    return Chip(avatar: Icon(icon, size: 18), label: Text('$label · $status'));
  }
}
