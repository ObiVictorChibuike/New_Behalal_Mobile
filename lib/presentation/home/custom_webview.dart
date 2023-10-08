import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/router.dart';
import 'package:behalal/app/universal_utils/loader.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/data/models/failure_models/failure.dart';
import 'package:behalal/data/repository/auth_repository/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  CustomWebView({Key? key, required this.url, required this.reference}) : super(key: key);
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final String url;
  final String reference;

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  _onBackPressed(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to return to the app?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          GetBuilder<AuthController>(
            builder: (_controller) {
              return GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop(false);
                  Loader.showLoader();
                  await _controller.getWalletBalance();
                  Get.back();
                  Get.offAllNamed(Routes.homeView);
                },
                child: const Text("YES"),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: AppColors.lightPrimaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'WithHalal - Fund Wallet',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () => Get.back(), //verifyFundWithCard(reference),
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              progress == 100
                  ? print('WebView is loading (progress : $progress%)')
                  : LoadingAnimationWidget.discreteCircle(
                color: AppColors.primaryColor,
                secondRingColor: Colors.white,
                thirdRingColor: Colors.white,
                size: 200,
              );
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            gestureNavigationEnabled: true,
            backgroundColor: AppColors.lightPrimaryColor,
          );
        }),
      ),
    );
  }
}

class VerifyCardFund extends StatelessWidget {
  const VerifyCardFund({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: 'Flexible Savings',
      //   dashboard: false,
      //   whiteBG: true,
      //   bgColor: AppColors.white,
      // ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            message.contains('Payment not successful') ? const Icon(Icons.cancel_outlined) : SvgPicture.asset(SVGImages.checkk),
            const Spacing.height(40),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacing.height(150),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AppButton(label: 'Return to Dashboard', onPressed: () => Get.offAllNamed(Routes.homeView)),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> verifyFundWithCard(reference) async {
  final _authController = Get.find<AuthController>();
  final _authenticationService = Get.find<AuthenticationService>();
  try {
    Loader.showLoader();
    // String message = await _authenticationService.verifyFundWithCard(
    //   reference: reference,
    // );
    // await _authController.getWalletBalance();
    // Get.off(
    //   () => VerifyCardFund(
    //     message: message,
    //   ),
    // );
  } on Failure catch (ex) {
    Get.off(
      () => VerifyCardFund(
        message: ex.message,
      ),
    );
  }
}
