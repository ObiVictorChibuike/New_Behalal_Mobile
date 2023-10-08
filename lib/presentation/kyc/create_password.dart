import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/local_session_manager/local_session_manager.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/password_check_indicator.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreatePassword extends StatefulWidget {
  final bool? isFromResetPassword;
  const CreatePassword({super.key, this.isFromResetPassword});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LocalSessionManager localSessionManager = LocalSessionManager();
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: GetBuilder<AuthController>(
        init: AuthController(),
          builder: (controller){
        return Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20),
              child: FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 1000),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    elevation: 0.0, label: 'Next', borderRadius: 30,
                    borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                    color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()){
                        widget.isFromResetPassword == true ? null : Navigator.pushReplacementNamed(Get.context!, Routes.setUpPasscode);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          appBar: const CustomAppBar(title: '', dashboard: false, bgColor: AppColors.white, whiteBG: true,),
          body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark))),
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
                                child: widget.isFromResetPassword == true ?
                                ListTile(
                                  contentPadding: const EdgeInsets.all(1),
                                  title: Text(
                                    "Change login password", textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 36.0.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ) :
                                ListTile(
                                  contentPadding: const EdgeInsets.all(1),
                                  title: RichText(text:
                                  TextSpan(text: "Almost there, ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black),
                                      children: [
                                        TextSpan(text: localSessionManager.getUserName ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.primaryColor)),
                                      ])),
                                ),
                              ),
                            ),
                            Align(alignment: Alignment.centerLeft,
                              child: FadeInDown(
                                duration: const Duration(milliseconds: 800),
                                child: widget.isFromResetPassword == true ? Text(
                                  'You cannot use the previous password again, please enter what you will remember.',
                                  style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                                ) :
                                Text(
                                  'Add your email address and set up your \npassword.',
                                  style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                                ),
                              ),
                            ),
                            const Spacing.height(20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: AppTextField(
                                label: null, controller: emailController,
                                hintText: 'E-mail Address',
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onChanged: controller.onEmailChanged,
                                validator: controller.validateEmail,
                              ),
                            ),
                            const Spacing.height(20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 1000),
                              child: AppTextField(
                                label: null, suffixIcon: const Icon(Iconsax.eye_slash),
                                hintText: 'Create Password', controller: passwordController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onChanged: controller.onPasswordChanged,
                                validator: controller.validatePassword,
                              ),
                            ),
                            Spacing.height(20.h,),
                            FadeInUp(
                                duration: const Duration(milliseconds: 800),
                                delay: const Duration(milliseconds: 1000),
                                child: const PasswordCheckIndicator()
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
        );
      }),
    );
  }
}
