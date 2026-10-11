import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme.dart';

class FlyerApp extends ConsumerWidget {
  const FlyerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flyer',
      debugShowCheckedModeBanner: false,
      theme: FlyerTheme.light(),
      darkTheme: FlyerTheme.dark(),
      routerConfig: router,
    );
  }
}
