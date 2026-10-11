import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuration Supabase résolue au démarrage.
///
/// L'app tolère l'absence de `.env` ou de clés : elle démarre alors en mode
/// « non configuré » (aucun appel réseau, écran de connexion placeholder).
@immutable
class SupabaseConfig {
  const SupabaseConfig._({required this.url, required this.anonKey});

  const SupabaseConfig.unconfigured() : url = null, anonKey = null;

  final String? url;
  final String? anonKey;

  bool get isConfigured =>
      url != null && url!.isNotEmpty && anonKey != null && anonKey!.isNotEmpty;

  /// Charge `.env`, puis initialise Supabase si les variables sont présentes.
  static Future<SupabaseConfig> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      debugPrint('Flyer : fichier .env introuvable, mode non configuré ($e).');
      return const SupabaseConfig.unconfigured();
    }

    final url = dotenv.maybeGet('SUPABASE_URL');
    final anonKey = dotenv.maybeGet('SUPABASE_ANON_KEY');
    final config = SupabaseConfig._(url: url, anonKey: anonKey);

    if (!config.isConfigured ||
        _isPlaceholder(url!) ||
        _isPlaceholder(anonKey!)) {
      debugPrint(
        'Flyer : SUPABASE_URL / SUPABASE_ANON_KEY absents ou non renseignés, '
        'mode non configuré.',
      );
      return const SupabaseConfig.unconfigured();
    }

    try {
      // La clé anon (ou « publishable ») est publique par conception : la
      // sécurité repose sur les politiques RLS côté Supabase.
      await Supabase.initialize(url: url, publishableKey: anonKey);
      return config;
    } catch (e) {
      debugPrint('Flyer : échec d\'initialisation Supabase ($e).');
      return const SupabaseConfig.unconfigured();
    }
  }

  static bool _isPlaceholder(String value) =>
      value.contains('votre-') || value.contains('your-');
}

/// Configuration injectée depuis `main.dart` (override obligatoire).
final supabaseConfigProvider = Provider<SupabaseConfig>(
  (ref) => const SupabaseConfig.unconfigured(),
);

/// Client Supabase, ou `null` si l'app n'est pas configurée.
final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  final config = ref.watch(supabaseConfigProvider);
  return config.isConfigured ? Supabase.instance.client : null;
});
