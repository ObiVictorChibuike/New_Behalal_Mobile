import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/universal_utils/success_screen.dart';
import 'package:behalal/app/widgets/app_check_box.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/controller/home_controllers/home_controller.dart';
import 'package:behalal/presentation/auth/login_view.dart';
import 'package:behalal/presentation/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_identity_kyc/flutter_identity_kyc.dart';

class ProtectYourIdentity extends StatefulWidget {
  const ProtectYourIdentity({super.key});

  @override
  State<ProtectYourIdentity> createState() => _ProtectYourIdentityState();
}

class _ProtectYourIdentityState extends State<ProtectYourIdentity> {
  var isChecked = false;
  final homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    requestPermissions();
    homeController.getDashboard();
  }

  Future<void> Function() requestPermissions = () async {
    await Permission.camera.request().isGranted;
    await Permission.microphone.request();
  };
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height/3.3, padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
          child: Column(
            children: [
              const Spacing.height(20),
              AppCheckBox(onChanged: (value){
                setState(() {
                  isChecked = !isChecked;
                });
              }, isChecked: isChecked, isSwitch: true),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 1000),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    elevation: 0.0, label: 'Proceed to verification', borderRadius: 30,
                    borderColor: AppColors.primaryColor,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      FlutterIdentityKyc.showWidget(InputParameters(
                          context: context,
                          merchantKey: "live_pk_I6YG0FY8dHmGkZssx2Z488kdbSrGGpoUJA87LGB",
                          firstName: homeController.dashBoardResponseModel?.data?.userdetail?.firstName ?? "",
                          lastName: homeController.dashBoardResponseModel?.data?.userdetail?.lastName ?? "",
                          email: homeController.dashBoardResponseModel?.data?.userdetail?.email ?? "" ,
                          userRef: homeController.dashBoardResponseModel?.data?.userdetail?.id ?? "",
                          config:"https://dashboard.prembly.com/",
                          onCancel: (response) {
                          },
                          onVerified: (response) {
                            Get.offAll(()=> SuccessScreen(onTap: (){
                              Get.delete<HomeController>();
                              Get.offAll(()=> const LoginView());
                            }, buttonLabel: "Proceed to Login",));
                          },
                          onError: (error){

                          }));
                    },
                  ),
                ),
              ),
              Spacing.height(12.h),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 1000),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppFlatButton(label: "I'll Do that later", onPressed: (){
                    Get.offAll(()=> SuccessScreen(onTap: (){
                      Get.offAll(()=> const LoginView());
                    }, buttonLabel: "Proceed to Login",));
                  }, textColor: AppColors.primaryColor,),
                ),
              ),
              // Spacing.height(50.h),
            ],
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
                    return Column(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 800),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(1),
                              title: Text(
                                'Protect your identity..',
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
                              'We are required by law to protect your identity from fraudsters from pretending to be you.',
                              style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                            ),
                          ),
                        ),
                        const Spacing.height(20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 1000),
                          child: Column(
                            children: [
                              Image.asset(PNGImages.verify, height: 250, width: 250,),
                              const Spacing.height(10),
                              Text('Why we need your BVN?',
                                style: TextStyle(color: const Color(0xff808A9A), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                              )
                            ],
                          ),
                        ),
                        Spacing.height(MediaQuery.of(context).size.height/3,),
                      ],
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
