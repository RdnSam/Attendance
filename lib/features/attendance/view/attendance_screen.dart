import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/attendance_controller.dart';

class AbsenScreen extends StatelessWidget {
  const AbsenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AbsenController());

    return Scaffold(
      appBar: AppBar(title: const Text("Absen Harian")),
      body: Center(
        child:Obx(() => controller.isLoading.value
    ? const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text("Mencari lokasi koordinat...", style: TextStyle(fontSize: 16)),
        ],
      )
    : ElevatedButton(
        onPressed: controller.absenMasuk,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade700,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: const Text("Absen Masuk", style: TextStyle(fontSize: 18)),
      )),

      ),
    );
  }
}
