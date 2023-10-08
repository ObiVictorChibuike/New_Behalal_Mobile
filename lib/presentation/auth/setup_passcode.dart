import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/universal_utils/loader.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class SetUpPasscode extends StatefulWidget {
  const SetUpPasscode({super.key});

  @override
  State<SetUpPasscode> createState() => _SetUpPasscodeState();
}

class _SetUpPasscodeState extends State<SetUpPasscode> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(title: '', dashboard: false, bgColor: AppColors.white, whiteBG: true,),
        body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark), fit: BoxFit.cover)),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16,),
                child: GetBuilder<AuthController>(
                  builder: (controller) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FadeInDown(
                            duration: const Duration(milliseconds: 1000),
                            delay: const Duration(milliseconds: 800),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(1),
                                title: Text(
                                  'Secure with Codes',
                                  style: TextStyle(
                                    fontSize: 36.0.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(alignment: Alignment.centerLeft,
                            child: FadeInDown(
                              duration: const Duration(milliseconds: 800),
                              child: Text(
                                'Protect your transaction and login using a passcode. This should be something you alone are familiar with.',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(47),
                          Align(alignment: Alignment.centerLeft,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: Text('Enter a 4 digit pin',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 14.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(18),
                          Align(alignment: Alignment.centerLeft,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: PinCodeTextField(
                                controller: controller.pinCodeController,
                                hideCharacter: true,
                                highlight: true,
                                highlightColor: Colors.blue,
                                pinBoxRadius: 8,
                                defaultBorderColor: const Color(0xffEBEBEB),
                                hasTextBorderColor: AppColors.primaryColor,
                                highlightPinBoxColor: AppColors.white,
                                maxLength: 4,
                                pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                                // hasError: hasError,
                                // maskCharacter: "😎",
                                onDone: (text) => controller.onPassCodeChanged(text),
                                pinBoxWidth: 45,
                                pinBoxHeight: 45,
                                wrapAlignment: WrapAlignment.spaceAround,
                                pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                pinTextStyle: TextStyle(fontSize: 22.0.sp),
                                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                                pinBoxColor: Colors.white,
                                pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                                highlightAnimation: true,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          const Spacing.height(24),
                          Align(alignment: Alignment.centerLeft,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: Text('Confirm your pin',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 14.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(18),
                          Align(alignment: Alignment.centerLeft,
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: PinCodeTextField(
                                controller: controller.confirmPinCodeController,
                                hideCharacter: true,
                                highlight: true,
                                highlightColor: Colors.blue,
                                pinBoxRadius: 8,
                                defaultBorderColor: const Color(0xffEBEBEB),
                                hasTextBorderColor: AppColors.primaryColor,
                                highlightPinBoxColor: AppColors.white,
                                maxLength: 4,
                                pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                                // hasError: hasError,
                                // maskCharacter: "😎",
                                onDone: (text) => controller.onOTPCodeChanged(text),
                                pinBoxWidth: 45,
                                pinBoxHeight: 45,
                                wrapAlignment: WrapAlignment.spaceAround,
                                pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                pinTextStyle: TextStyle(fontSize: 22.0.sp),
                                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                                pinBoxColor: Colors.white,
                                pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                                highlightAnimation: true,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          Spacing.height(
                            MediaQuery.of(context).size.height/2.7,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AppButton(
                                elevation: 0.0, label: 'Next', borderRadius: 30,
                                borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                onPressed: () async {
                                  if(controller.pinCodeController.value.text != controller.confirmPinCodeController.value.text){
                                    Loader.progressIndicator(Get.context!);
                                    Future.delayed(const Duration(seconds: 5), (){
                                      Navigator.of(context).pop();
                                      SnackbarUtil.showErrorSnackbar("Passcode do not match");
                                    });
                                  }else{
                                    controller.createUserDetails();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
