import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/route_names.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());


    return Obx((){
      return Stack(
        children:[
        Scaffold(
        appBar: AppBar(title: const Text("Register")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Buat Akun Baru",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: controller.nisnController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'NISN (10 digit)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: controller.nisController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'NIS (5 digit)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: controller.selectedRole.value,
                  onChanged: controller.setRole,
                  items: const [
                    DropdownMenuItem(value: "siswa", child: Text("Siswa")),
                    DropdownMenuItem(value: "guru", child: Text("Guru")),
                  ],
                  decoration: const InputDecoration(labelText: "Pilih Role"),
                ),
                const SizedBox(height: 16),
                controller.sekolahList.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : DropdownButtonFormField<int>(
                        value: controller.selectedSekolahId.value,
                        onChanged: controller.setSekolah,
                       items: controller.sekolahList.map<DropdownMenuItem<int>>((s) {
                      return DropdownMenuItem<int>(
                        value: s['id'] as int,
                        child: Text(s['namaSekolah']),
                      );
                    }).toList(),

                        decoration: const InputDecoration(labelText: "Pilih Sekolah"),
                      ),

                              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            final success = await controller.register();
                            if (success) {
                              context.go(RouteNames.otp); 
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Daftar", style: TextStyle(fontSize: 16)),
                  ),
                ),

              ],
            );
          }),
        ),
      ),
        
    ),
   if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
    });
  }
}