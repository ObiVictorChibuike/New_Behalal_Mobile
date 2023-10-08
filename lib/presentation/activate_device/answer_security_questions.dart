import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AnswerSecurityQuestions extends StatefulWidget {
  const AnswerSecurityQuestions({super.key});

  @override
  State<AnswerSecurityQuestions> createState() => _AnswerSecurityQuestionsState();
}

class _AnswerSecurityQuestionsState extends State<AnswerSecurityQuestions> {
  final _formKey = GlobalKey<FormState>();
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
                                "Answer security questions", textAlign: TextAlign.start,
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
                              'We need to reconfirm your identity in order to keep you safe from fraudsters. ',
                              style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                            ),
                          ),
                        ),
                        const Spacing.height(20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: AppTextField(
                            label: null,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: _controller.onReferalCodeChanged,
                            // validator: _controller.validateNotEmpty,
                          ),
                        ),
                        const Spacing.height(8),
                        Align(alignment: Alignment.centerLeft,
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              'Security question 1',
                              style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                            ),
                          ),
                        ),
                        const Spacing.height(20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: AppTextField(
                            label: null,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: _controller.onReferalCodeChanged,
                            // validator: _controller.validateNotEmpty,
                          ),
                        ),
                        const Spacing.height(8),
                        Align(alignment: Alignment.centerLeft,
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              'Security question 2',
                              style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                            ),
                          ),
                        ),
                        const Spacing.height(50),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AppButton(
                              elevation: 0.0, label: 'Verify', borderRadius: 30,
                              borderColor: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              color: _formKey.currentState?.validate()  == true ? AppColors.primaryColor : AppColors.inActive,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()){

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
    );
  }
}
