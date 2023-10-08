import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/local_session_manager/local_session_manager.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  LocalSessionManager localSessionManager = LocalSessionManager();

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
                                  "Let\’s know you better", textAlign: TextAlign.start,
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
                                'Enter your information to set up your Halal \naccount.',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                              ),
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: AppTextField(
                              label: null, controller: firstNameController,
                              hintText: 'First Name',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: controller.onFirstNameChanged,
                              validator: controller.validateNotEmpty,
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: AppTextField(
                              label: null, controller: lastNameController,
                              hintText: 'Last Name',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: controller.onLastNameChanged,
                              validator: controller.validateNotEmpty,
                            ),
                          ),
                          Spacing.height(MediaQuery.of(context).size.height/2.2,),
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
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()){
                                    localSessionManager.authUserName = lastNameController.text;
                                    Navigator.pushNamed(context, Routes.createPassword);
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
