import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme.dart';
import '../../../core/supabase/supabase_client.dart';
import 'auth_providers.dart';

/// Écran de connexion (FL-101). Placeholder navigable : les boutons sociaux
/// seront branchés en Sprint 1.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref
          .read(authStateProvider.notifier)
          .signInWithPassword(_email.text.trim(), _password.text);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final configured = ref.watch(supabaseConfigProvider).isConfigured;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(FlyerSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.photo_camera_outlined,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: FlyerSpacing.md),
                  Text(
                    'Flyer',
                    style: theme.textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Crée ton event, Flyer s\'occupe de le faire connaître.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: FlyerSpacing.xl),
                  if (!configured)
                    Card(
                      color: theme.colorScheme.tertiaryContainer,
                      child: const Padding(
                        padding: EdgeInsets.all(FlyerSpacing.md),
                        child: Text(
                          'Supabase n\'est pas configuré. Copiez `.env.example` '
                          'vers `.env` et renseignez SUPABASE_URL et '
                          'SUPABASE_ANON_KEY pour activer la connexion.',
                        ),
                      ),
                    ),
                  const SizedBox(height: FlyerSpacing.md),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: FlyerSpacing.sm),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: FlyerSpacing.sm),
                    Text(
                      _error!,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ],
                  const SizedBox(height: FlyerSpacing.md),
                  FilledButton(
                    onPressed: configured && !_loading ? _submit : null,
                    child: _loading
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Se connecter'),
                  ),
                  const SizedBox(height: FlyerSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.apple),
                    label: const Text('Continuer avec Apple (S1)'),
                  ),
                  const SizedBox(height: FlyerSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Continuer avec Google (S1)'),
                  ),
                  const SizedBox(height: FlyerSpacing.md),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.signUp),
                    child: const Text('Pas encore de compte ? Créer un compte'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
