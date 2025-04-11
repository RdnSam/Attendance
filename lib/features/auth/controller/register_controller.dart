import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/route_names.dart';
import '../services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xpresensi_app/core/utils/snackbar_helper.dart'; // pastikan path ini sesuai struktur project kamu

class RegisterController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nisnController = TextEditingController();
  final nisController = TextEditingController();

  // State
  final selectedRole = "siswa".obs;
  final selectedSekolahId = RxnInt();
  final sekolahList = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchSekolahList();
  }

  void setRole(String? value) {
    if (value != null) selectedRole.value = value;
  }

  void setSekolah(int? id) {
    selectedSekolahId.value = id;
  }

  Future<void> fetchSekolahList() async {
    final result = await AuthService.getSekolahList();
    print("DEBUG sekolah result: $result");

    if (result['success']) {
      final data = result['data'];
      if (data is List) {
        sekolahList.assignAll(List<Map<String, dynamic>>.from(data));
      } else {
        SnackbarHelper.error('Data sekolah tidak valid');
      }
    } else {
      SnackbarHelper.error(result['message'] ?? 'Tidak bisa ambil sekolah');
    }
  }

Future<bool> register() async {
  if (selectedSekolahId.value == null) {
    SnackbarHelper.error('Silakan pilih sekolah terlebih dahulu');
    return false;
  }

  isLoading.value = true;

  final result = await AuthService.register(
    name: nameController.text,
    email: emailController.text,
    password: passwordController.text,
    nisn: nisnController.text,
    nis: nisController.text,
    sekolahId: selectedSekolahId.value!,
    role: selectedRole.value,
  );

  isLoading.value = false;

  print("📦 RAW API response: $result");
  final isSuccess = result['success'] == true;
  final user = result['data'];

  if (isSuccess && user is Map) {
    final userId = user['id'];
    final otp = user['verificationToken'];

    if (userId != null && otp != null) {
      await storage.write(key: 'userId', value: userId.toString());
      await storage.write(key: 'otp', value: otp.toString());
      return true;
    } else {
      SnackbarHelper.error('Data tidak lengkap dari server');
    }
  } else {
    SnackbarHelper.error(result['message'] ?? 'Gagal melakukan pendaftaran');
  }

  return false;
}

}

