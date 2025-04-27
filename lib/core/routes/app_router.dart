import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xpresensi_app/core/routes/main_shell_screen.dart';
import 'package:xpresensi_app/features/attendance/view/attendance_screen.dart';
import 'package:xpresensi_app/features/auth/view/otp_screen.dart';
import 'package:xpresensi_app/features/auth/view/register_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/auth/view/login_screen.dart';

import '../../features/auth/view/splash_screen.dart';

import 'route_names.dart';

final _storage = const FlutterSecureStorage();

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteNames.otp,
      builder: (context, state) => const OtpScreen(),
    ),

    /// HANYA ADA DI SINI 👇
    ShellRoute(
      builder: (context, state, child) {
        return MainShellScreen(child: child);
      },
      routes: [
        GoRoute(
          path: RouteNames.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: RouteNames.attendance,
          builder: (context, state) => const AbsenScreen(),
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final token = await _storage.read(key: 'token');
    final isLogin = token != null;

    final location = state.uri.toString();

    if (!isLogin && ![
      RouteNames.login,
      RouteNames.register,
      RouteNames.otp,
      RouteNames.splash,
    ].contains(location)) {
      return RouteNames.login;
    }

    if (isLogin && location == RouteNames.login) {
      return RouteNames.dashboard;
    }

    return null;
  },
);
