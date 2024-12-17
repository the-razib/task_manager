import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBerMessage(String message,
    [bool isError = false]) {
  Get.showSnackbar(GetSnackBar(
    message: message,
      backgroundColor: isError ? Colors.red : Colors.green,
    animationDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 3),
    ),);
}

