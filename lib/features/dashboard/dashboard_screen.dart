import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/route_names.dart';
import '../../features/auth/services/user_services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? userRole;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    userRole = await UserService.getRole();
    userId = await UserService.getUserId();
    setState(() {});
  }

  void _logout() async {
    await UserService.logout();
    if (mounted) context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selamat datang 👋", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text("Role: $userRole"),
            Text("User ID: $userId"),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/attendance'),
              child: const Text("Absen Harian"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
