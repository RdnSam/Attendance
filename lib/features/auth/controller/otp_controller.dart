import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xpresensi_app/core/utils/snackbar_helper.dart';
import '../services/auth_services.dart';
class OtpController extends GetxController {
  final otpController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<bool> verifyOtp() async {
    final result = await AuthService.verifyOtp(otpController.text);
  print("📤 Mengirim kode verifikasi: ${otpController.text}");

    if (result['success']) {
      await storage.delete(key: 'otp');
      return true;
    } else {
      SnackbarHelper.error(result['message'] ?? 'OTP salah atau sudah kedaluwarsa');
      return false;
    }
  }
}
