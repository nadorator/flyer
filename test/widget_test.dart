import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flyer/app/app.dart';
import 'package:flyer/core/supabase/supabase_client.dart';

void main() {
  Widget buildApp() => ProviderScope(
    overrides: [
      supabaseConfigProvider.overrideWithValue(
        const SupabaseConfig.unconfigured(),
      ),
    ],
    child: const FlyerApp(),
  );

  testWidgets('démarre sur l\'écran de connexion sans Supabase configuré', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Flyer'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.textContaining('Supabase n\'est pas configuré'), findsOneWidget);

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('navigue vers la page d\'inscription', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    final link = find.text('Pas encore de compte ? Créer un compte');
    await tester.ensureVisible(link);
    await tester.tap(link);
    await tester.pumpAndSettle();

    expect(find.text('Créer un compte'), findsWidgets);
    expect(find.textContaining('Sprint 1'), findsOneWidget);
  });
}
