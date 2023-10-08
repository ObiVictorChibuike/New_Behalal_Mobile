import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/controller/startup_controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  //Move to the next route after 200 Milliseconds
  decideNavigation(){
    Future.delayed(const Duration(milliseconds: 200), (){
      Navigator.pushReplacementNamed(context, Routes.onBoardingView);
    });
  }

  @override
  void initState() {
    decideNavigation(); //Called it here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset(
                SVGImages.splashBG,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: GetBuilder<SplashController>(
                init: SplashController(),
                builder: (controller) => AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.decelerate,
                  width: controller.width,
                  height: controller.width + 4,
                  onEnd: () => controller.onEnd(),
                  child: SvgPicture.asset(
                    SVGImages.nameLogo,
                    // fit: BoxFit.cover,
                    color: AppColors.white,
                  ),
                  // builder: (controller) => SvgPicture.asset(
                  //   SVGImages.nameLogo,
                  //   fit: BoxFit.cover,
                  //   color: AppColors.white,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
