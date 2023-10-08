import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/router.dart';
import 'package:behalal/app/widgets/app_phone_textfield.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CreateTransactionPIN extends StatelessWidget {
  CreateTransactionPIN({Key? key}) : super(key: key);

  final AdvancedSwitchController _switchController = AdvancedSwitchController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark), fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: GetBuilder<AuthController>(
              builder: (_controller) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(1),
                          leading: IconButton(
                            icon: SvgPicture.asset(
                              SVGImages.back,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          title: Text(
                            'Transaction PIN',
                            style: TextStyle(
                              fontSize: 25.0.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const Spacing.height(10),
                      Text(
                        'Create your Withhalal account passcode to secure your transactions. your PIN is a 4 digit number.',
                        style: TextStyle(color: const Color(0xffb8b8b8), fontSize: 13.sp),
                      ),
                      const Spacing.height(40),
                      AppTextField(
                        label: 'PIN',
                        hintText: 'Input pin',
                        keyboardType: TextInputType.number,
                        obscureText: !(_controller.showPassword),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        textInputAction: TextInputAction.next,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.showPassword ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: _controller.togglePasswordVisibility,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            SVGImages.lock,
                          ),
                        ),
                        onChanged: _controller.onPassCodeChanged,
                        validator: _controller.validatePasscode,
                      ),
                      const Spacing.height(20),
                      AppTextField(
                          label: 'Confirm PIN',
                          hintText: 'Input pin',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                          ],
                          obscureText: !(_controller.showPassword),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _controller.showPassword ? Icons.visibility_off : Icons.visibility,
                              size: 20,
                            ),
                            onPressed: _controller.togglePasswordVisibility,
                          ),
                          textInputAction: TextInputAction.next,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              SVGImages.lock,
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty || val != _controller.transactionPIN) return 'PIN does not match';
                            return null;
                          }),
                      const Spacing.height(10),
                      // AppSwitch(label: 'Include fingerprint or facial login ', controller: _switchController),
                      const Spacing.height(40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                          label: 'Secure Account',
                          // isLoading: _controller.state is LoadingState,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) return;
                            await _controller.createTransactionPIN();
                          },
                        ),
                      ),
                      const Spacing.height(5),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordReset extends StatelessWidget {
  PasswordReset({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GetBuilder<AuthController>(
            builder: (_controller) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      // delay: const Duration(milliseconds: 800),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(1),
                          leading: IconButton(
                            icon: SvgPicture.asset(
                              SVGImages.back,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          title: Text(
                            'Password Reset',
                            style: TextStyle(
                              fontSize: 25.0.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacing.height(10),
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Enter the phone number connected with your Withhalal account, we will send you an OTP code to reset your password.',
                        style: TextStyle(color: const Color(0xffb8b8b8), fontSize: 13.sp),
                      ),
                    ),
                    const Spacing.height(50),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 800),
                      child: AppPhoneTextField(
                        label: 'Phone Number',
                        hintText: 'Input phone number',
                        textInputAction: TextInputAction.next,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            SVGImages.phone,
                          ),
                        ),
                        onChanged: _controller.onPhoneNumberChanged,
                        validator: _controller.validatePhoneNumber,
                      ),
                    ),
                    const Spacing.height(20),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 1600),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Receive verification code by:',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 1800),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 3),
                              title: Text(
                                'SMS',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),
                              value: 'sms',
                              groupValue: _controller.otpMethodSMS,
                              onChanged: (value) => _controller.otp(value),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 3),
                              title: Text(
                                'Voice call',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),
                              value: 'voice',
                              groupValue: _controller.otpMethodSMS,
                              onChanged: (value) => _controller.otp(value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacing.height(70),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 2200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                          label: 'Send OTP',
                          // isLoading: _controller.state is LoadingState,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) return;
                            await _controller.passwordResetOTP();
                          },
                        ),
                      ),
                    ),
                    // const Spacing.height(5),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 2400),
                      child: AppFlatButton(
                        label: 'Already have an account? Login',
                        textColor: const Color(0xff9F9F9F),
                        onPressed: () => Get.offAllNamed(Routes.loginView),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PasswordReset2 extends StatelessWidget {
  PasswordReset2({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GetBuilder<AuthController>(
            builder: (_controller) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      // delay: const Duration(milliseconds: 800),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(1),
                          leading: IconButton(
                            icon: SvgPicture.asset(
                              SVGImages.back,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          title: Text(
                            'Password Reset',
                            style: TextStyle(
                              fontSize: 25.0.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacing.height(10),
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Your new password must be different from your old password.',
                        style: TextStyle(color: const Color(0xffb8b8b8), fontSize: 13.sp),
                      ),
                    ),
                    const Spacing.height(50),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 800),
                      child: AppTextField(
                        label: 'New Password',
                        hintText: '',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        obscureText: !(_controller.showPassword),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.showPassword ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: _controller.togglePasswordVisibility,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            SVGImages.lock,
                          ),
                        ),
                        onChanged: _controller.onPasswordChanged,
                        validator: _controller.validatePassword,
                      ),
                    ),
                    const Spacing.height(20),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 800),
                      child: AppTextField(
                        label: 'Confirm New Password',
                        hintText: '',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: !(_controller.showPassword),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.showPassword ? Icons.visibility_off : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: _controller.togglePasswordVisibility,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            SVGImages.lock,
                          ),
                        ),
                        onChanged: _controller.onConfirmPasswordChanged,
                        validator: _controller.validatePassword,
                      ),
                    ),
                    const Spacing.height(70),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 2200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                          label: 'Reset Password',
                          // isLoading: _controller.state is LoadingState,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) return;
                            await _controller.passwordReset();
                          },
                        ),
                      ),
                    ),
                    const Spacing.height(5),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
