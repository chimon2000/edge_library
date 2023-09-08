import 'package:edge_library_app/pages/book_detail/book_detail_screen.dart';
import 'package:edge_library_app/pages/book_list/book_list_screen.dart';
import 'package:edge_library_app/pages/landing/landing_page.dart';
import 'package:edge_library_app/pages/login/login_page.dart';
import 'package:edge_library_app/pages/onboarding_page/onboarding_page.dart';
import 'package:edge_library_app/pages/patron/patron_detail_screen.dart';
import 'package:edge_library_app/pages/welcome/welcome_page.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    path: '/',
    redirect: (context, state) => '/landing',
  ),
  GoRoute(
    name: 'landing',
    path: '/landing',
    builder: (context, state) => const LandingPage(),
  ),
  GoRoute(
    name: 'welcome',
    path: '/welcome',
    builder: (context, state) => const WelcomePage(),
    routes: [
      GoRoute(
        name: 'login',
        path: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'onboarding',
        path: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
    ],
  ),
  GoRoute(
    name: 'book-list',
    path: '/books',
    builder: (context, state) => const BooksListScreen(),
    routes: [
      GoRoute(
        name: 'book-details',
        path: ':id',
        builder: (context, state) =>
            BookDetailScreen(id: state.pathParameters['id']!),
      ),
    ],
  ),
  GoRoute(
    name: 'patron',
    path: '/patron',
    builder: (context, state) => PatronDetailScreen(),
  ),
];
