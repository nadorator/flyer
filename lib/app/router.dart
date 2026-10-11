import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/ai_content/presentation/flyer_generator_page.dart';
import '../features/auth/presentation/auth_providers.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/sign_up_page.dart';
import '../features/billing/presentation/partner_code_page.dart';
import '../features/billing/presentation/paywall_page.dart';
import '../features/business_profile/presentation/business_profile_page.dart';
import '../features/crm/presentation/customer_list_page.dart';
import '../features/events/presentation/event_form_page.dart';
import '../features/events/presentation/event_list_page.dart';
import '../features/partner_kit/presentation/partner_kit_page.dart';
import '../features/publishing/presentation/platform_needs_page.dart';

/// Routes nommées de l'application (voir `docs/07-architecture.md`).
abstract final class AppRoutes {
  static const login = '/login';
  static const signUp = '/sign-up';
  static const events = '/events';
  static const eventNew = '/events/new';
  static const eventEdit = '/events/:id/edit';
  static const eventGenerate = '/events/:id/generate';
  static const eventNeeds = '/events/:id/needs';
  static const eventPartnerKit = '/events/:id/partner-kit';
  static const businessProfile = '/profile';
  static const customers = '/customers';
  static const paywall = '/paywall';
  static const partnerCode = '/partner-code';

  static String eventEditPath(String id) => '/events/$id/edit';
  static String eventGeneratePath(String id) => '/events/$id/generate';
  static String eventNeedsPath(String id) => '/events/$id/needs';
  static String eventPartnerKitPath(String id) => '/events/$id/partner-kit';

  static const _publicPaths = {login, signUp};

  static bool isPublic(String path) => _publicPaths.contains(path);
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isPublic = AppRoutes.isPublic(state.matchedLocation);
      if (!authState.isAuthenticated && !isPublic) return AppRoutes.login;
      if (authState.isAuthenticated && isPublic) return AppRoutes.events;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.events,
        builder: (context, state) => const EventListPage(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const EventFormPage(),
          ),
          GoRoute(
            path: ':id/edit',
            builder: (context, state) =>
                EventFormPage(eventId: state.pathParameters['id']),
          ),
          GoRoute(
            path: ':id/generate',
            builder: (context, state) =>
                FlyerGeneratorPage(eventId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: ':id/needs',
            builder: (context, state) =>
                PlatformNeedsPage(eventId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: ':id/partner-kit',
            builder: (context, state) =>
                PartnerKitPage(eventId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.businessProfile,
        builder: (context, state) => const BusinessProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.customers,
        builder: (context, state) => const CustomerListPage(),
      ),
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        path: AppRoutes.partnerCode,
        builder: (context, state) => const PartnerCodePage(),
      ),
    ],
  );
});
