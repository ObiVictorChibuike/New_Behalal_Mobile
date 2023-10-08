import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/app_phone_textfield.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/presentation/auth/verify_forgot_password_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _LoginViewState();
}

class _LoginViewState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

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
                  builder: (_controller) {
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
                                  "Forgot password?", textAlign: TextAlign.start,
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
                                'Enter your phone number',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 800),
                            child: AppPhoneTextField(
                              label: null,
                              hintText: 'Phone Number',
                              textInputAction: TextInputAction.next,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  SVGImages.user,
                                ),
                              ),
                              onChanged: _controller.onPhoneNumberChanged,
                              validator: _controller.validatePhoneNumber,
                            ),
                          ),
                          Spacing.height(MediaQuery.of(context).size.height/4.2),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AppButton(
                                elevation: 0.0, label: 'Send Otp', borderRadius: 30,
                                borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const VerifyForgotPassword()));
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacing.height(56),
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