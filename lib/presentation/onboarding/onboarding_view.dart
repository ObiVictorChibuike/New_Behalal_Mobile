import 'dart:io';
import 'dart:math';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/startup_controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final _curve = Curves.ease;
  final _duration = const Duration(milliseconds: 300);
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (_controller) {
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _controller.pages.length,
                itemBuilder: (context, index) {
                  return OnboardingItem(
                    imageUrl: _controller.pages[index].imageUrl,
                    title: _controller.pages[index].title,
                    description: _controller.pages[index].description,
                  );
                },
                physics: const BouncingScrollPhysics(),
                onPageChanged: _controller.onPageChanged,
              ),
              if (_controller.currentPage == 0)
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom.h + 20.h, left: 30.w, right: 30.w),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AppButton(
                      label: 'Start your journey to freedom',
                      color: AppColors.white,
                      onBoarding: true,
                      withIcons: true,
                      textColor: AppColors.primaryColor,
                      borderRadius: 15.r,
                      suffixIcon: const Icon(
                        Icons.arrow_forward_outlined,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () => _pageController.nextPage(
                        duration: _duration,
                        curve: _curve,
                      ),
                    ),
                  ),
                )
              else if (_controller.currentPage == 3)
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom.h + 20.h, left: 30.w, right: 30.w),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AppButton(
                      label: 'Continue',
                      withIcons: true,
                      borderRadius: 15.r,
                      onBoarding: true,
                      color: AppColors.white,
                      onPressed: () => Get.bottomSheet(
                        AppBottomSheet(
                            content: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppButton(
                                    label: 'Create an account',
                                    borderRadius: 20.r,
                                    onBoarding: false,
                                    textColor: AppColors.white,
                                    // color: AppColors.white,
                                    onPressed: () => Navigator.pushReplacementNamed(context, Routes.pickAvatarAvi),
                                  ),
                                  AppFlatButton(
                                    textColor: AppColors.primaryColor,
                                    label: 'Already have an account? Login',
                                    onPressed: () => Get.toNamed(Routes.login),
                                  ),
                                ],
                              ),
                            ),
                            title: ''),
                      ),
                    ),
                  ),
                )
              else
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom.h + 20.h,
                      right: 30,
                      left: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _controller.currentPage == 3
                            ? const AppFlatButton.empty()
                            : AppFlatButton(
                                label: 'Skip',
                                onPressed: () => Get.toNamed(Routes.login),
                              ),
                        AppButton(
                          label: 'Proceed',
                          borderRadius: 25.r,
                          onBoarding: true,
                          withIcons: true,
                          suffixIcon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.primaryColor,
                          ),
                          color: AppColors.white,
                          onPressed: () => _pageController.nextPage(
                            duration: _duration,
                            curve: _curve,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  final String description;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClippedPartsWidget(
      top: SizedBox(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.fitWidth,
        ),
      ),
      bottom: _OnboardingOverlay(
        description: description,
        title: title,
      ),
      splitFunction: (Size size, double x) {
        final normalizedX = x / size.width * 2 * pi;
        final waveHeight = size.height / 15;
        final y = size.height / 2 - sin(normalizedX) * waveHeight;
        return y;
      },
    );
  }
}

class _OnboardingOverlay extends StatelessWidget {
  const _OnboardingOverlay({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 800),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: SvgPicture.asset(
                      SVGImages.nameLogo,
                      color: AppColors.white,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const Spacing.height(20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
              Spacing.height(20.h),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacing.height(5.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ClippedPartsWidget extends StatelessWidget {
  const ClippedPartsWidget({
    Key? key,
    required this.top,
    required this.bottom,
    required this.splitFunction,
  }) : super(key: key);

  final double Function(Size, double) splitFunction;
  final Widget bottom;
  final Widget top;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        top,
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: bottom,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  FunctionClipper({required this.splitFunction}) : super();

  final double Function(Size, double) splitFunction;

  @override
  Path getClip(Size size) {
    final path = Path();
    if (Platform.isIOS) {
      path.moveTo(0, size.height * 0.72);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.75, size.width * 0.5, size.height * 0.7);
      path.quadraticBezierTo(size.width * 0.75, size.height * 0.65, size.width * 1.0, size.height * 0.68);
    } else {
      path.moveTo(0, size.height * 0.6667);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.73337, size.width * 0.5, size.height * 0.64997);
      path.quadraticBezierTo(size.width * 0.75, size.height * 0.56667, size.width * 1.0, size.height * 0.61667);
    }

    // path.moveTo(0, 71.h);
    // path.quadraticBezierTo(size.width * 0.25, 76.h, size.width * 0.5, 71.h);
    // path.quadraticBezierTo(size.width * 0.75, 65.h, size.width * 1.0, 70.h);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
