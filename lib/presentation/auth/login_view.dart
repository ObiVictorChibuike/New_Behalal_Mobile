import 'dart:developer';

import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/app_check_box.dart';
import 'package:behalal/app/widgets/app_phone_textfield.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/presentation/activate_device/activate_new_device.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:animate_do/animate_do.dart';

class WelcomeBack extends StatefulWidget {
  WelcomeBack({Key? key}) : super(key: key);

  @override
  State<WelcomeBack> createState() => _WelcomeBackState();
}

class _WelcomeBackState extends State<WelcomeBack> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    PNGImages.loginBG,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 30,
                child: SvgPicture.asset(
                  SVGImages.nameLogo,
                  color: AppColors.primaryColor,
                  height: 30,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                  child: GetBuilder<AuthController>(
                    builder: (_controller) {
                      return Form(
                        key: _formKey,
                        child: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark))),
                          child: Column(
                            children: [
                              const Spacing.height(10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              const Spacing.height(5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${_controller.user!.firstName}, ${_controller.user!.lastName}',
                                  style: TextStyle(
                                    fontSize: 23.0.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              const Spacing.height(20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Input your passcode',
                                  style: TextStyle(
                                    fontSize: 15.0.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              const Spacing.height(10),
                              PinCodeTextField(
                                controller: _controller.pinCodeController,
                                hideCharacter: true,
                                highlight: true,
                                highlightColor: Colors.blue,
                                pinBoxRadius: 8,
                                defaultBorderColor: AppColors.primaryColor,
                                hasTextBorderColor: AppColors.primaryColor,
                                highlightPinBoxColor: AppColors.white,
                                maxLength: 4,
                                pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                                // hasError: hasError,
                                // maskCharacter: "😎",
                                onDone: (text) => _controller.onPassCodeChanged(text),
                                pinBoxWidth: 52,
                                pinBoxHeight: 52,
                                wrapAlignment: WrapAlignment.spaceAround,
                                pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                pinTextStyle: TextStyle(fontSize: 22.0.sp),
                                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                                pinBoxColor: Colors.white,
                                pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                                highlightAnimation: true,
                                keyboardType: TextInputType.number,
                              ),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: AppFlatButton(
                              //     label: 'Forgot Passcode?',
                              //     textColor: AppColors.black,
                              //     onPressed: () {},
                              //   ),
                              // ),
                              const Spacing.height(30),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: AppButton(
                                  label: 'Log in',
                                  // isLoading: _controller.state is LoadingState,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (!_formKey.currentState!.validate()) return;
                                    await _controller.welcomeBack();
                                  },
                                ),
                              ),
                              AppFlatButton(
                                label: 'End of Session? Sign Out',
                                textColor: const Color(0xff9F9F9F),
                                onPressed: () => _controller.signOut(),
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //     // print('object');
                              //   },
                              //   child: Column(
                              //     children: [
                              //       SvgPicture.asset(
                              //         SVGImages.faceID,
                              //       ),
                              //       const Spacing.height(10),
                              //       Text(
                              //         'Login using Face ID',
                              //         style: TextStyle(
                              //           fontSize: 12.0.sp,
                              //           fontWeight: FontWeight.w400,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.white), height: MediaQuery.of(context).size.height/10,
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(PNGImages.support, height: 20, width: 20,),
                const Spacing.width(5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Need help? ",
                        style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                            color: Colors.black54, fontFamily: AppString.fontFamily1
                        ),
                      ),
                      TextSpan(text: "Contact Halal support",
                        style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor, fontFamily: AppString.fontFamily1
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
                                  "Welcome back! Halalian", textAlign: TextAlign.start,
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
                                'Provide your login details',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 800),
                            child: AppPhoneTextField(
                              label: null, controller: phoneNumberController,
                              hintText: 'Phone Number',
                              textInputAction: TextInputAction.next,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  SVGImages.user,
                                ),
                              ),
                              onChanged: controller.onPhoneNumberChanged,
                              validator: (PhoneNumber? phoneNumber) {
                                if ((phoneNumber != null && phoneNumber.number.length < 10)) {
                                  return 'Enter a Valid Phone Number';
                                }else if (phoneNumber != null && phoneNumber.number.length != 11) {
                                  return 'Enter a Valid Phone Number';
                                }else if(phoneNumberController.text.isEmpty){
                                  return "Enter a Valid Phone Number";
                                }
                                return null;
                              },
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: AppTextField(
                              controller: passwordController,
                              obscureText: hidePassword,
                              label: null, suffixIcon: GestureDetector(
                              onTap: (){
                               setState(() {
                                 hidePassword = !hidePassword;
                               });
                              },
                                child: hidePassword == false ? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye)),
                              hintText: 'Enter Password',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: controller.onPasswordChanged,
                              validator: controller.validateNotEmpty,
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: AppCheckBox(
                                onChanged: (value){
                                  controller.acceptTermsConditions(value);
                                }, isChecked: controller.acceptTerms,
                                isSwitch: false, label: Text('Remember Password', style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),),
                            ),
                          ),
                          const Spacing.height(47),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AppButton(
                                elevation: 0.0, label: 'Sign In', borderRadius: 30,
                                borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()){
                                    await controller.login();
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacing.height(8),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ActivateNewDevice()));
                                  },
                                  child: Text("Activate Device", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14,
                                      fontWeight: FontWeight.w400, color: AppColors.primaryColor),),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, Routes.forgotPassword);
                                  },
                                  child: Text("Forgot Password?", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14,
                                      fontWeight: FontWeight.w400, color: AppColors.grey),),
                                ),
                              ],
                            ),
                          ),
                          const Spacing.height(56),
                          FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 800),
                              child: Align(alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      const Icon(Icons.fingerprint, color: AppColors.grey, size: 60,),
                                      // Image.asset(PNGImages.faceId),
                                      Text("Sign in using Biometrics", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14,
                                          fontWeight: FontWeight.w400, color: AppColors.grey),)
                                    ],
                                  )
                              )
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
