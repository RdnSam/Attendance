import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void show(String title, String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('$title: $message'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // fallback kalau context belum attach
      debugPrint('⚠️ [$title] $message');
    }
  }

  static void error(String message) {
    show('Error', message);
  }

  static void success(String message) {
    show('Sukses', message);
  }

  static void info(String message) {
    show('Info', message);
  }
}
