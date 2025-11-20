
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

import '../../features/deals/presentation/screens/future_deals_screen.dart';
import '../../features/deals/presentation/screens/active_deals_screen.dart';
import '../../features/deals/presentation/screens/completed_deals_screen.dart';
import '../../features/deals/presentation/screens/deal_details_screen.dart';
import '../../features/payments/presentation/screens/payment_options_screen.dart';
import '../../features/payments/presentation/screens/payment_success_screen.dart';
import '../../features/orders/presentation/screens/my_orders_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState;
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      if (!isLoggedIn && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return '/deals/future';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/deals/future',
        builder: (context, state) => const FutureDealsScreen(),
      ),
      GoRoute(
        path: '/deals/active',
        builder: (context, state) => const ActiveDealsScreen(),
      ),
      GoRoute(
        path: '/deals/completed',
        builder: (context, state) => const CompletedDealsScreen(),
      ),
      GoRoute(
        path: '/deals/:id',
        builder: (context, state) => DealDetailsScreen(dealId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const MyOrdersScreen(),
      ),
      GoRoute(
        path: '/payment/options',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PaymentOptionsScreen(
            orderId: extra['orderId'],
            amount: extra['amount'],
          );
        },
      ),
      GoRoute(
        path: '/payment/success',
        builder: (context, state) => const PaymentSuccessScreen(),
      ),
    ],
  );
});
