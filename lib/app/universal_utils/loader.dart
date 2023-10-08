import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader {
  static void progressIndicator(BuildContext? context) {
    showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (context) => Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 1),
            child:  Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.primaryColor,
                  secondRingColor: Colors.white,
                  thirdRingColor: Colors.white,
                size: 50,
              ),
            )));

  }
  static void showLoader() {
    Get.dialog(
       Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: AppColors.primaryColor,
          secondRingColor: Colors.white,
          thirdRingColor: Colors.white,
          size: 200,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
