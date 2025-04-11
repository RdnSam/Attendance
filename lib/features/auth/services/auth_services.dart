import 'package:dio/dio.dart';
import 'package:xpresensi_app/core/bindings/dio_config.dart';
import 'package:xpresensi_app/core/constants/endpoints.dart';

class AuthService {
  static final _dio = DioConfig.getInstance();

    static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await _dio.post(Endpoints.login, data: {
        'email': email,
        'password': password,
      });
      return res.data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }
static Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
  required String nisn,
  required String nis,
  required String role,
  required int sekolahId,
}) async {
  try {
    final res = await _dio.post(Endpoints.signup, data: {
      "email": email,
      "name": name,
      "password": password,
      "nisn": nisn,
      "nis": nis,
      "role": role,
      "sekolahId": sekolahId,
    });

    print("🔥 FULL RESPONSE DATA => ${res.data}");

    // Safe unwrap
    final outer = res.data;
    final nested = outer['data'];
    final user = nested is Map ? nested['data'] : null;

    return {
      "success": nested?['success'] ?? outer['success'],
      "message": nested?['message'] ?? outer['message'],
      "data": user,
    };
  } on DioException catch (e) {
    final errorMsg = e.response?.data?['message'] ?? e.message;
    return {
      "success": false,
      "message": errorMsg ?? "Terjadi kesalahan saat register"
    };
  } catch (e) {
    return {"success": false, "message": "Error: ${e.toString()}"};
  }
}



static Future<Map<String, dynamic>> verifyOtp(String code) async {
  try {
    final res = await _dio.post(Endpoints.verifyOtp, data: {
      "code": code,
    });

    return res.data;
  } on DioException catch (e) {
    print("⚠️ [Error] ${e.toString()}");
    return {
      "success": false,
      "message": e.response?.data?['message'] ?? "Kode verifikasi tidak valid"
    };
  } catch (e) {
    return {"success": false, "message": "Error: ${e.toString()}"};
  }
}

static Future<Map<String, dynamic>> getSekolahList() async {
  try {
    final res = await _dio.get(Endpoints.sekolah);
    return {"success": true, "data": res.data['data']};
  } catch (e) {
    return {"success": false, "message": "Gagal ambil data sekolah"};
  }
}


}
