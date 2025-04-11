import 'dart:io';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xpresensi_app/core/utils/snackbar_helper.dart';
import '../../../data/services/attendance_service.dart';

// import '../services/attendance_services.dart';

class AbsenController extends GetxController {
  final isLoading = false.obs;

Future<void> absenMasuk() async {
  isLoading.value = true;

  try {
    // ✅ Minta izin lokasi & kamera
    final locationStatus = await Permission.location.request();
    final cameraStatus = await Permission.camera.request();

    if (!locationStatus.isGranted || !cameraStatus.isGranted) {
      SnackbarHelper.error("Izin lokasi dan kamera wajib diizinkan.");
      isLoading.value = false;
      return;
    }

    // ✅ Ambil lokasi
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // ✅ Ambil foto kamera
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      SnackbarHelper.error("Tidak ada foto diambil");
      isLoading.value = false;
      return;
    }

    // ✅ Kirim ke API
    final result = await AttendanceService.absenMasuk(
      foto: File(pickedFile.path),
      latitude: position.latitude,
      longitude: position.longitude,
    );

    if (result['success']) {
      SnackbarHelper.success(result['message'] ?? "Absen berhasil");
    } else {
      SnackbarHelper.error(result['message'] ?? "Absen gagal");
    }
  } catch (e) {
    SnackbarHelper.error("Error: $e");
  }

  isLoading.value = false;
}
}