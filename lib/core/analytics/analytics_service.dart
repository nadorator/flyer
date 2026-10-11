import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase/supabase_client.dart';

/// Événements analytiques Lean UX (voir `docs/01-lean-ux-canvas.md`).
///
/// Chaque événement est rattaché à une hypothèse ; les noms sont figés ici pour
/// garantir la traçabilité entre le code, la base `analytics_events` et les
/// tableaux de bord de sprint review.
enum AnalyticsEvent {
  // E1 — Auth & profil (H0)
  signUp('sign_up'),
  businessProfileCompleted('business_profile_completed'),

  // E2 — Events (H0)
  eventCreated('event_created'),

  // E3 — IA & flyers (H1)
  flyerGenerated('flyer_generated'),
  shareSheetOpened('share_sheet_opened'),

  // E4 — Besoins & publication (H1)
  needMarkedProvided('need_marked_provided'),
  publishSuccess('publish_success'),
  publishFailed('publish_failed'),

  // E5 — Kit partenaire & page publique (H2, H6)
  partnerKitShared('partner_kit_shared'),
  partnerKitOpened('partner_kit_opened'),
  partnerKitChecked('partner_kit_checked'),
  bookingClicked('booking_clicked'),

  // E6 — CRM (H4)
  customerImported('customer_imported'),
  customerExported('customer_exported'),
  customerDeleted('customer_deleted'),
  crmSynced('crm_synced'),

  // E7 — Monétisation & codes partenaires (H3, H5)
  quotaReached('quota_reached'),
  paywallViewed('paywall_viewed'),
  subscriptionStarted('subscription_started'),
  partnerCodeRedeemed('partner_code_redeemed'),
  feedbackSubmitted('feedback_submitted');

  const AnalyticsEvent(this.key);

  /// Nom stocké dans `analytics_events.name`.
  final String key;
}

/// Service d'analytics : insère dans `analytics_events` quand Supabase est
/// configuré, sinon journalise en console (mode développement / tests).
class AnalyticsService {
  AnalyticsService(this._client);

  final SupabaseClient? _client;

  Future<void> track(
    AnalyticsEvent event, {
    Map<String, Object?> props = const {},
  }) async {
    if (_client == null) {
      debugPrint('[analytics] ${event.key} $props');
      return;
    }
    try {
      await _client.from('analytics_events').insert({
        'name': event.key,
        'props': props,
        'user_id': _client.auth.currentUser?.id,
      });
    } catch (e) {
      // L'analytics ne doit jamais faire échouer un parcours utilisateur.
      debugPrint('[analytics] échec ${event.key}: $e');
    }
  }
}

final analyticsServiceProvider = Provider<AnalyticsService>(
  (ref) => AnalyticsService(ref.watch(supabaseClientProvider)),
);
