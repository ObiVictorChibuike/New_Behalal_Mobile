import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showSnackbar(String text) {
    Get.snackbar(
      'Success: ',
      '',
      messageText: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
      ),
      icon: const Icon(
        Icons.check_circle_outline_rounded,
        color: AppColors.white,
      ),
      backgroundColor: const Color(0xff167416),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      borderRadius: 10,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void showErrorSnackbar(String text) {
    Get.snackbar(
      'Error: ',
      '',
      colorText: Colors.white,
      messageText: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
      ),
      icon: const Icon(
        Icons.cancel_outlined,
        color: AppColors.white,
      ),
      backgroundColor: Get.theme.errorColor,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      borderRadius: 10,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
