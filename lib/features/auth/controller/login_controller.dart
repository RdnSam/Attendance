import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final storage = const FlutterSecureStorage();

  Future<bool> login() async {
    isLoading.value = true;

    final email = emailController.text.trim();
    final password = passwordController.text;

    final result = await AuthService.login(email, password);
    isLoading.value = false;

    if (result['success']) {
      final token = result['data']['token'];
      final role = result['data']['role'];

      await storage.write(key: 'token', value: token);
      await storage.write(key: 'role', value: role);

      if (role == 'siswa' || role == 'guru') {
        return true; // Navigasi dilakukan di view
      } else {
        Get.snackbar('Error', 'Role tidak dikenali');
        return false;
      }
    } else {
      Get.snackbar('Gagal Login', result['message'] ?? 'Cek koneksi atau kredensial');
      return false;
    }
  }
}
