import 'dart:io';
import 'package:dio/dio.dart';
import 'package:xpresensi_app/core/bindings/dio_config.dart';

import 'package:xpresensi_app/core/constants/endpoints.dart';
import 'package:xpresensi_app/features/auth/services/user_services.dart';

class AttendanceService {
  static Future<Map<String, dynamic>> _submitAbsen({
    required File foto,
    required double latitude,
    required double longitude,
    required String endpoint,
  }) async {
    final token = await UserService.getToken();
    if (token == null) return {"success": false, "message": "Token tidak tersedia"};

    final dio = DioConfig.getInstance(token: token!);

    final formData = FormData.fromMap({
      "fotoAbsen": await MultipartFile.fromFile(foto.path, filename: 'absen.jpg'),
      "latitude": latitude,
      "longitude": longitude,
    });

    try {
      final response = await dio.post(endpoint, data: formData);
      return response.data;
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> absenMasuk({
    required File foto,
    required double latitude,
    required double longitude,
  }) {
    return _submitAbsen(
      foto: foto,
      latitude: latitude,
      longitude: longitude,
      endpoint: Endpoints.absenMasuk,
    );
  }

  static Future<Map<String, dynamic>> absenPulang({
    required File foto,
    required double latitude,
    required double longitude,
  }) {
    return _submitAbsen(
      foto: foto,
      latitude: latitude,
      longitude: longitude,
      endpoint: Endpoints.absenPulang,
    );
  }
}
