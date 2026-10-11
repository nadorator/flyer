import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/placeholder_page.dart';

/// Inscription (FL-101) — placeholder, implémentation en Sprint 1.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Créer un compte',
      icon: Icons.person_add_alt_1_outlined,
      description:
          'Inscription par email, Apple ou Google, puis saisie du profil '
          'entreprise qui alimentera automatiquement vos flyers.',
      sprint: 'Sprint 1 · FL-101',
      actions: [
        OutlinedButton(
          onPressed: () => context.go(AppRoutes.login),
          child: const Text('Retour à la connexion'),
        ),
      ],
    );
  }
}
