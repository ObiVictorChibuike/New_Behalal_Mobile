import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/universal_utils/timer/custom_countdown_timer.dart';
import 'package:behalal/app/widgets/app_phone_textfield.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:animate_do/animate_do.dart';

class CreateAccount extends StatefulWidget {
  final String imagePath;
  const CreateAccount({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(title: '', dashboard: false, bgColor: AppColors.white, whiteBG: true, actions: Image.asset(widget.imagePath),),
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
                                  "Let\'s get you set!", textAlign: TextAlign.start,
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
                              label: null, controller: phoneNumberController,
                              hintText: 'Phone Number',
                              textInputAction: TextInputAction.next,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(
                                  SVGImages.user,
                                ),
                              ),
                              onChanged: _controller.onPhoneNumberChanged,
                              validator: (value){
                                return value!.number;
                              },
                            ),
                          ),
                          const Spacing.height(20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                            child: AppTextField(
                              label: null, controller: referralCodeController,
                              hintText: 'Do you have referral code?',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: _controller.onReferalCodeChanged,
                              // validator: _controller.validateNotEmpty,
                            ),
                          ),
                          const Spacing.height(67),
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
                                    await _controller.register();
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

class SignUpSuccessView extends StatefulWidget {
  const SignUpSuccessView({Key? key}) : super(key: key);

  @override
  State<SignUpSuccessView> createState() => _SignUpSuccessViewState();
}

class _SignUpSuccessViewState extends State<SignUpSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(SVGImages.signUpSuccess),
            ),
            const Spacing.height(40),
            GetBuilder<AuthController>(
              builder: (_controller) {
                return Text(
                  'Welcome onboard,', //\n${_controller.firstName}!',
                  style: TextStyle(
                    fontSize: 30.0.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                );
              },
            ),
            const Spacing.height(30),
            Text(
              "Your Withhalal account is all set, you can now perform all transactions without limits.\n\nWelcome to the family, you are on your path to financial freedom.",
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w400,
                // color: AppColors.primaryColor,
              ),
            ),
            const Spacing.height(50),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AppButton(
                label: 'Login to continue',
                onPressed: (){},
                // onPressed: () => Get.offAllNamed(Routes.loginView),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key, required this.fromSignUp}) : super(key: key);

  final bool? fromSignUp;

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
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
      body: Padding(
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
                  widget.fromSignUp! ? 'We have sent a 6 digit code to +234******42. Kindly enter the code below to verify your phone number' : 'Please enter the OTP code sent to the phone number connected to your Withhalal account.',
                  style: TextStyle(color: const Color(0xffb8b8b8), fontSize: 18.sp, fontFamily: AppString.fontFamily1),
                ),
              ),
            ),
            const Spacing.height(40),
            GetBuilder<AuthController>(
              builder: (_controller) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacing.height(10),
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 1000),
                        child: PinCodeTextField(
                          controller: _controller.pinCodeController,
                          hideCharacter: true,
                          highlight: true,
                          highlightColor: Colors.blue,
                          pinBoxRadius: 8,
                          defaultBorderColor: const Color(0xffEBEBEB),
                          hasTextBorderColor: AppColors.primaryColor,
                          highlightPinBoxColor: AppColors.white,
                          maxLength: 6,
                          pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          // hasError: hasError,
                          // maskCharacter: "😎",
                          onDone: (text) => _controller.onOTPCodeChanged(text),
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
                      const Spacing.height(33),
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 1000),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.timer, color: Colors.red, size: 15),
                              _controller.time == 0 ?
                              GestureDetector(
                                onTap: () {
                                  _controller.startCountdown();
                                }, child: Text("Resend",
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ),) : Text(getTimeForCountDown(_controller.time),
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
                            // isLoading: _controller.state is LoadingState,
                            onPressed: () async {
                              // Navigator.pushNamed(context, Routes.kyc, arguments: true);
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()){
                                // await _controller.verifyOTP(widget.fromSignUp);
                              };
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
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1000),
              child: RichText(text: TextSpan(text: "Didn’t get any code? ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff808A9A)),
                  children: [
                TextSpan(text: "Resend OTP", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
              ])),
            )
          ],
        ),
      ),
    );
  }
}

class VerifyOTPSuccessDialog extends StatelessWidget {
  const VerifyOTPSuccessDialog({
    Key? key,
    required String? firstName,
  })  : _firstName = firstName,
        super(key: key);

  final String? _firstName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Yay, $_firstName',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          const Spacing.height(10),
          Text(
            'OTP verified and account is created',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.black, fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
          const Spacing.height(10),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100,
              // width: 100,
              child: SvgPicture.asset(SVGImages.signUpSuccess),
            ),
          ),
          // const Spacing.height(20),
          // Text(
          //   'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: AppColors.black,
          //     fontSize: 12.sp,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          const Spacing.height(20),
          AppButton(
            label: 'Proceed to secure account',
            withIcons: true, onPressed: (){},
            // onPressed: () => Get.offNamed(Routes.createPasscodeView),
            suffixIcon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }
}
