import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/supabase/supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lit `.env` et initialise Supabase si l'URL et la clé sont présentes.
  // En l'absence de configuration, l'app démarre en mode « non configuré ».
  final config = await SupabaseConfig.load();

  runApp(
    ProviderScope(
      overrides: [supabaseConfigProvider.overrideWithValue(config)],
      child: const FlyerApp(),
    ),
  );
}
