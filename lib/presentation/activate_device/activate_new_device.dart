import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/app_phone_textfield.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/presentation/activate_device/verify_activate_device_phonenumber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ActivateNewDevice extends StatefulWidget {
  const ActivateNewDevice({super.key});

  @override
  State<ActivateNewDevice> createState() => _ActivateNewDeviceState();
}

class _ActivateNewDeviceState extends State<ActivateNewDevice> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(title: '', dashboard: false, bgColor: AppColors.white, whiteBG: true,),
        body: SafeArea(
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
                                "Activate new device", textAlign: TextAlign.start,
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
                              'Enter your registered phone number',
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
                        const Spacing.height(20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: AppTextField(
                            obscureText: hidePassword,
                            label: null, suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.grey,),
                            hintText: 'Changed Device',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: _controller.onPasswordChanged,
                            // validator: _controller.validateNotEmpty,
                          ),
                        ),
                        const Spacing.height(47),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AppButton(
                              elevation: 0.0, label: 'Send OTP', borderRadius: 30,
                              borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const VerifyActivateDevicePhoneNumber()));
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
    );
  }
}
