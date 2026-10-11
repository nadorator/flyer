import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_client.dart';

/// État d'authentification exposé au routeur et aux pages.
@immutable
class AuthState {
  const AuthState({required this.isAuthenticated, this.userId, this.email});

  const AuthState.signedOut()
    : isAuthenticated = false,
      userId = null,
      email = null;

  final bool isAuthenticated;
  final String? userId;
  final String? email;
}

/// Suit la session Supabase. En mode non configuré, l'utilisateur est
/// considéré comme déconnecté (écran de connexion placeholder).
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final client = ref.watch(supabaseClientProvider);
    if (client == null) return const AuthState.signedOut();

    final sub = client.auth.onAuthStateChange.listen((data) {
      state = _fromSession(data.session);
    });
    ref.onDispose(sub.cancel);

    return _fromSession(client.auth.currentSession);
  }

  AuthState _fromSession(Session? session) {
    final user = session?.user;
    if (user == null) return const AuthState.signedOut();
    return AuthState(isAuthenticated: true, userId: user.id, email: user.email);
  }

  /// Connexion par email / mot de passe (FL-101). Implémentation réelle en S1.
  Future<void> signInWithPassword(String email, String password) async {
    final client = ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase non configuré : renseignez .env');
    }
    await client.auth.signInWithPassword(email: email, password: password);
  }

  /// Inscription par email / mot de passe (FL-101). Implémentation réelle en S1.
  Future<void> signUp(String email, String password) async {
    final client = ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase non configuré : renseignez .env');
    }
    await client.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await ref.read(supabaseClientProvider)?.auth.signOut();
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
