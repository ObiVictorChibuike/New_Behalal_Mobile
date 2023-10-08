import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/universal_utils/timer/custom_countdown_timer.dart';
import 'package:behalal/app/widgets/app_generic_dialog.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class VerifyPhoneNumber extends StatefulWidget {
final String identifier;
final String phoneNumber;
final bool isFromLogin;
  const VerifyPhoneNumber({super.key, required this.identifier, required this.phoneNumber, required this.isFromLogin});

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AuthController());
  @override
  void initState() {
    _controller.startCountdown();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: '', dashboard: false, bgColor: AppColors.white, whiteBG: true,),
      body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                // delay: const Duration(milliseconds: 800),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(1),
                    title: Text(
                      'Verify phone number',
                      style: TextStyle(
                        fontSize: 36.0.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacing.height(10),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 1000),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'We have sent a 6 digit code to ${widget.phoneNumber}. Kindly enter the code below to verify your phone number',
                    style: TextStyle(color: const Color(0xffb8b8b8), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                  ),
                ),
              ),
              const Spacing.height(40),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Spacing.height(10),
                        FadeInUp(
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
                            maxLength: widget.isFromLogin == true ? 7 : 7,
                            pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: widget.isFromLogin == true ? 3 : 4.0),
                            // hasError: hasError,
                            // maskCharacter: "😎",
                            onDone: (text) => controller.onOTPCodeChanged(text),
                            pinBoxWidth: 40 ,
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
                        const Spacing.height(33),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.timer, color: Colors.red, size: 15),
                                controller.time == 0 ?
                                GestureDetector(
                                  onTap: () {
                                    controller.startCountdown();
                                  }, child: Text("Resend",
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                  ),
                                ),) : Text(getTimeForCountDown(controller.time),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacing.height(62),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AppButton(
                              elevation: 0.0, borderRadius: 30,
                              borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              label: 'Verify',
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if(widget.isFromLogin == true && _formKey.currentState!.validate()){
                                  controller.verifyLoginPhoneNumber();
                                }else{
                                  if (widget.isFromLogin == false && _formKey.currentState!.validate()){
                                    await controller.verifyOTP(identifier: widget.identifier);
                                  }
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
              const Spacing.height(26),
             GetBuilder<AuthController>(
               init: AuthController(),
                 builder: (controller){
               return FadeInUp(
                 duration: const Duration(milliseconds: 800),
                 delay: const Duration(milliseconds: 1000),
                 child: RichText(text: TextSpan(text: "Didn’t get any code? ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff808A9A)),
                     children: [
                       TextSpan(text: "Resend OTP", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
                           recognizer: TapGestureRecognizer()..onTap = (){
                             showExpiredsessionDialog(context, "Didn't receive OTP?", "Resend OTP", () async {
                               if(widget.isFromLogin == true){
                                 Get.back();
                                 _controller.resendLoginOtp();
                                 controller.startCountdown();
                                 setState(() {});
                               }else{
                                 Get.back();
                                 _controller.resendOtp(identifier: widget.identifier);
                                 controller.startCountdown();
                                 setState(() {});
                               }
                             });
                           }),
                     ])),
               );
             })
            ],
          ),
        ),
      ),
    );
  }
}

