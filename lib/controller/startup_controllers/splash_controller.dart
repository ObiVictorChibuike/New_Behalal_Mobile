import 'package:behalal/app/router/router.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  double width = 80;

  // final _authenticationController = Get.find<AuthController>();

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 400), () => animateLogo());
    _decideNavigation();
    super.onInit();
  }

  void animateLogo() {
    width = 110;
    update();
  }

  void onEnd() {
    width = width == 80 ? 110 : 80;
    update();
  }

  void _decideNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    try {

      // Get.offAllNamed(Routes.onboardingView);
      // final user = await _authenticationController.getUser();
      // if (user == null) {
      //   Get.offAllNamed(Routes.onboardingView);
      // } else {
      //   Get.offAllNamed(Routes.welcomeBackView);
      // }
    } catch (ex) {
      // log(ex.toString());
      // log(s.toString());
      Get.offAllNamed(Routes.onboardingView);
    }
  }
}
