import 'package:freezed_annotation/freezed_annotation.dart';

/// Plans d'abonnement (voir `docs/05-monetisation.md`).
///
/// Le plan effectif est toujours résolu côté serveur (`current_plan()`), les
/// quotas ci-dessous servent uniquement à l'affichage du paywall.
enum Plan {
  @JsonValue('free')
  free,
  @JsonValue('pro')
  pro,
  @JsonValue('studio')
  studio,
  @JsonValue('partner')
  partner,
}

/// Quotas d'un plan ; `null` = illimité.
class PlanQuotas {
  const PlanQuotas({
    required this.eventsPerMonth,
    required this.aiGenerationsPerMonth,
    required this.connectedPlatforms,
    required this.contacts,
    required this.watermark,
    required this.crmSync,
  });

  final int? eventsPerMonth;
  final int? aiGenerationsPerMonth;
  final int? connectedPlatforms;
  final int? contacts;
  final bool watermark;
  final bool crmSync;
}

extension PlanInfo on Plan {
  String get label => switch (this) {
    Plan.free => 'Gratuit',
    Plan.pro => 'Pro',
    Plan.studio => 'Studio',
    Plan.partner => 'Partenaire',
  };

  /// Prix mensuel indicatif en euros ; 0 pour les plans gratuits.
  double get monthlyPrice => switch (this) {
    Plan.free => 0,
    Plan.pro => 19,
    Plan.studio => 49,
    Plan.partner => 0,
  };

  PlanQuotas get quotas => switch (this) {
    Plan.free => const PlanQuotas(
      eventsPerMonth: 1,
      aiGenerationsPerMonth: 5,
      connectedPlatforms: 2,
      contacts: 50,
      watermark: true,
      crmSync: false,
    ),
    Plan.pro => const PlanQuotas(
      eventsPerMonth: null,
      aiGenerationsPerMonth: 100,
      connectedPlatforms: null,
      contacts: 2000,
      watermark: false,
      crmSync: false,
    ),
    Plan.studio || Plan.partner => const PlanQuotas(
      eventsPerMonth: null,
      aiGenerationsPerMonth: 300,
      connectedPlatforms: null,
      contacts: null,
      watermark: false,
      crmSync: true,
    ),
  };
}
