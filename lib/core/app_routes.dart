import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/cadastro_screen.dart';
import '../screens/upload_documento_screen.dart';
import '../screens/vincular_redes_screen.dart';
import '../screens/validar_links_screen.dart';
import '../screens/perfil_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _buildPageWithTransition(const SplashScreen(), state),
      ),
      GoRoute(
        path: '/cadastro',
        pageBuilder: (context, state) => _buildPageWithTransition(const CadastroScreen(), state),
      ),
      GoRoute(
        path: '/upload',
        pageBuilder: (context, state) => _buildPageWithTransition(const UploadDocumentoScreen(), state),
      ),
      GoRoute(
        path: '/redes',
        pageBuilder: (context, state) => _buildPageWithTransition(const VincularRedesScreen(), state),
      ),
      GoRoute(
        path: '/validar',
        pageBuilder: (context, state) => _buildPageWithTransition(const ValidarLinksScreen(), state),
      ),
      GoRoute(
        path: '/perfil',
        pageBuilder: (context, state) => _buildPageWithTransition(const PerfilScreen(), state),
      ),
    ],
  );

  static CustomTransitionPage _buildPageWithTransition(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
