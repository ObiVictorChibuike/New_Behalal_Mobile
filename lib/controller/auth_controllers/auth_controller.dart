import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:behalal/app/local_session_manager/local_session_manager.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/universal_utils/currency_util.dart';
import 'package:behalal/app/universal_utils/functions.dart';
import 'package:behalal/app/universal_utils/loader.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/universal_utils/state_notifier.dart';
import 'package:behalal/app/universal_utils/validation_mixin.dart';
import 'package:behalal/core/injector/injector.dart';
import 'package:behalal/data/models/auth_models/ads.dart';
import 'package:behalal/data/models/auth_models/login/login_request.dart';
import 'package:behalal/data/models/auth_models/login/login_response.dart';
import 'package:behalal/data/models/auth_models/registration/registeration_response_model_response.dart';
import 'package:behalal/data/models/auth_models/registration/registration_request_model_response.dart';
import 'package:behalal/data/models/auth_models/user.dart';
import 'package:behalal/data/models/auth_models/user_details/user_details_request_model.dart';
import 'package:behalal/data/models/auth_models/verify_otp/verify_otp_request_model_response.dart';
import 'package:behalal/data/models/failure_models/failure.dart';
import 'package:behalal/data/models/passcode_models/create_passcode_request_model.dart';
import 'package:behalal/data/repository/auth_repository/auth_service.dart';
import 'package:behalal/presentation/auth/create_account.dart';
import 'package:behalal/presentation/home/custom_webview.dart';
import 'package:behalal/presentation/kyc/protect_your_identity.dart';
import 'package:behalal/presentation/transfers/withdrawal.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:dio/dio.dart' as dio;

class AuthController extends StateNotifier with ValidationMixin {
  final AuthenticationService _authenticationService = sl<AuthenticationService>();
  LocalSessionManager localSessionManager = LocalSessionManager();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController confirmPinCodeController = TextEditingController();
  User? _user;
  String _deviceIdentifier = "id_not_found";

  final aviList = [
    "assets/png_images/avi1.png",
    "assets/png_images/avi2.png",
    "assets/png_images/avi3.png",
    "assets/png_images/avi4.png",
    "assets/png_images/avi5.png",
    "assets/png_images/avi6.png",
    "assets/png_images/avi7.png",
    "assets/png_images/avi8.png",
    "assets/png_images/avi9.png",
    "assets/png_images/avi10.png",
    "assets/png_images/avi11.png",
    "assets/png_images/avi12.png",
    "assets/png_images/avi13.png",
    "assets/png_images/avi14.png",
    "assets/png_images/avi15.png",
    "assets/png_images/avi16.png",
    "assets/png_images/avi17.png",
    "assets/png_images/avi18.png",
    "assets/png_images/avi19.png",
    "assets/png_images/avi20.png",
  ];




  String? _cooperative;
  String? _email;
  String? _firstName;
  String? _referalCode;
  String? _lastName;
  String? _otpCode;
  String? _fee;
  String? _otpMethodSMS = 'sms';
  String? _password;
  String? _confirmPassword;
  String? _fundAmount;
  String? _withdrawAmount;
  String? _transactionPIN;
  String? _phoneNumber;
  bool _showPassword = false;
  bool _acceptTerms = false;
  bool _hideBalance = true;
  bool _upto8Characters = false;
  bool _numbers = false;
  bool _lowerCase = false;
  bool _upperCase = false;
  bool _symbolSpecial = false;
  int _timeCount = 120;
  late Timer _timer;
  String? _walletBalance;
  String? _authURL;
  String? _reference;
  List<String> _fundWalletResponse = [];
  List<dynamic> _listBankAccounts = [];
  List<Ad>? _ads = [];

  User? get user => _user;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get fundAmount => _fundAmount;
  String? get fee => _fee;
  String? get withdrawAmount => _withdrawAmount;
  String? get phoneNumber => _phoneNumber;
  String? get cooperative => _cooperative;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  String? get referalCode => _referalCode;
  String? get transactionPIN => _transactionPIN;
  String? get otpMethodSMS => _otpMethodSMS;
  bool get showPassword => _showPassword;
  bool get hideBalance => _hideBalance;
  bool get acceptTerms => _acceptTerms;
  int get timeCount => _timeCount;
  bool get upTo8Characters => _upto8Characters;
  bool get numbers => _numbers;
  bool get lowerCase => _lowerCase;
  bool get upperCase => _upperCase;
  bool get symbolSpecial => _symbolSpecial;
  String? get otpCode => _otpCode;
  String? get walletBalance => _walletBalance;
  List<dynamic> get listBankAccounts => _listBankAccounts;
  int? get totalAmount => (double.parse(_fee!) + double.parse(CurrencyUtil.getAmount(_withdrawAmount!))).round();
  List<Ad>? get ads => _ads?.toList();

  set setPinCode(dynamic value) {
    _otpCode = value;
  }

  set setListBankAccounts(dynamic value) => _listBankAccounts = value;

  @override
  void onInit() async {
    super.onInit();
    getAds();
    getWalletBalance();
    // _kycController.tierDetails();
    getBankAccount();
  }

  int time = 180;
  late Timer timer;

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time == 0) {
        t.cancel();
        time = 180;
        update();
      } else {
        if (Get.context!.mounted) {
          time--;
          update();
        }
      }
    });
  }

  @override
  void dispose() {
    pinCodeController.clear();
    super.dispose();
  }

  void onFirstNameChanged(String value) {
    _firstName = value;
    update();
  }

  void onReferalCodeChanged(String value) {
    _referalCode = value;
    update();
  }

  void onLastNameChanged(String value) {
    _lastName = value;
    update();
  }
  void onPhoneNumberChanged(PhoneNumber phone) {
    _phoneNumber = phone.number;
    update();
  }

  void onFundAmount(String value) {
    _fundAmount = value;
    update();
  }

  void onWithdrawAmount(String value) {
    _withdrawAmount = value;
    update();
  }

  Functions function = Functions();

  void onEmailChanged(String value) {
    _email = value;
    update();
  }

  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) && function.checkUpperCase(value) && function.checknumbers(value) && function.specialCharacters(value) && value.length >= 8);
    return met;
  }

  void onPasswordChanged(String value) {
    if (value.length >= 8) {
      _upto8Characters = true;
      update();
    } else {
      _upto8Characters = false;
      update();
    }

    if (function.checkLoweCase(value)) {
      _lowerCase = true;
      update();
    } else {
      _lowerCase = false;
      update();
    }

    if (function.checknumbers(value)) {
      _numbers = true;
      update();
    } else {
      _numbers = false;
      update();
    }

    if (function.checkUpperCase(value)) {
      _upperCase = true;
      update();
    } else {
      _upperCase = false;
      update();
    }

    if (function.specialCharacters(value)) {
      _symbolSpecial = true;
      update();
    } else {
      _symbolSpecial = false;
      update();
    }
    if (checkRequirement(value)) {
      _password = value;
      update();
    } else {
      _password = null;
      update();
    }
    update();
  }

  void onConfirmPasswordChanged(String value) {
    _confirmPassword = value;
    update();
  }

  void onPassCodeChanged(String value) {
    _transactionPIN = value;
    update();
  }

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
    update();
  }

  void toggleBalanceVisibility() {
    _hideBalance = !_hideBalance;
    update();
  }

  void acceptTermsConditions(value) {
    _acceptTerms = value;
    update();
  }

  void otp(value) {
    _otpMethodSMS = value;
    update();
  }

  void onOTPCodeChanged(String value) {
    _otpCode = value;
    update();
  }

  Future<void> createPasscode() async {
    var identifier = localSessionManager.userIdentifier;
    try {
      Loader.progressIndicator(Get.context!);
      await _authenticationService.setPassCode(
          createPasscodeRequestModel: CreatePasscodeRequestModel(
            passcode: _transactionPIN,confirmPasscode: _transactionPIN, identifier: identifier,
          )).then((value){
        Navigator.pushReplacementNamed(Get.context!, Routes.protectIdentity);
      });
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> register() async {
    final deviceId = await getDeviceIdentifier();
    try {
      Loader.progressIndicator(Get.context!);
      final response = await _authenticationService.register(
          registrationRequestModelResponse: RegistrationRequestModelResponse(
              phoneNumber: _phoneNumber,
              referalBy: _referalCode,
              deviceId: deviceId
          ));
      final payload = RegistrationResponseModelResponse.fromJson(response?.data);
      log(payload.data!.identifier!.toString());
      Navigator.pushReplacementNamed(Get.context!, Routes.verifyPhoneNumber, arguments: VerifyOtpScreenArguments(payload.data!.identifier!.toString(), _phoneNumber!, false));
      _timeCount = 120;
      timerStart();
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> createUserDetails() async {
    try {
      Loader.progressIndicator(Get.context!);
      final identifier = localSessionManager.userIdentifier;
       await _authenticationService.createUserDetails(
          userDetailsRequestResponseModel: UserDetailsRequestResponseModel(
           identifier: identifier,
            firstName: _firstName,
            lastName: _lastName,
            email: _email,
            password: _password,
            passwordConfirmation: _password,
            passcode: confirmPinCodeController.text,
            confirmPasscode: confirmPinCodeController.text
          ));
       Get.offAll(()=> const ProtectYourIdentity());
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> verifyOTP({required String identifier}) async {
    try {
      Loader.progressIndicator(Get.context!);
      final response = await _authenticationService.verifyOTP(
          verifyOtpRequestModelResponse: VerifyOtpRequestModelResponse(
              identifier: identifier,
              otp: otpCode
          ));
      localSessionManager.authUserIdentifier = identifier;
      Navigator.pushReplacementNamed(Get.context!, Routes.kyc);
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> resendOtp({required String identifier}) async {
    try {
      Loader.progressIndicator(Get.context!);
      await _authenticationService.resendUserOtp(
        identifier: identifier,
      ).then((value){
        Navigator.of(Get.context!).pop();
      });
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }


  Future<dio.Response<dynamic>?> resendLoginOtp() async {
    try {
      Loader.progressIndicator(Get.context!);
      final response = await _authenticationService.resendUserLoginOtp();
        Navigator.of(Get.context!).pop();
        SnackbarUtil.showErrorSnackbar(response?.data["message"] ?? "Otp sent to your number");
      return response;
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> verifyLoginPhoneNumber() async {
    try {
      Loader.progressIndicator(Get.context!);
      await _authenticationService.verifyPhoneNumber(
        otp: otpCode!,
      ).then((value){
        Navigator.of(Get.context!).pop();
        Navigator.pushReplacementNamed(Get.context!, Routes.home);
      });
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> login() async {
    final deviceId = await getDeviceIdentifier();
    try {
      Loader.progressIndicator(Get.context!);

      final response = await _authenticationService.login(
          loginRequestModelResponse: LoginRequestModelResponse(
              phoneNumber: _phoneNumber,
              password: _password,
              deviceId: "123"//deviceId
          ));
      final payload = LoginResponseModel.fromJson(response?.data);
      localSessionManager.authTokenVal = payload.token!;
      Navigator.pushReplacementNamed(Get.context!, Routes.verifyPhoneNumber,  arguments: VerifyOtpScreenArguments("", "", true));
    }catch (err){
      Navigator.of(Get.context!).pop();
      SnackbarUtil.showErrorSnackbar(err.toString());
      throw err.toString();
    }
  }

  Future<void> welcomeBack() async {
    Loader.showLoader();
    try {
      if (_transactionPIN != null) {
        // await _authenticationService.welcomeBack(
        //   passCode: int.parse(_transactionPIN!),
        // );
        await getWalletBalance();
        _referalCode = _user!.referalCode;
        Get.back();
        // _ads!.isEmpty ? Get.toNamed(Routes.homeView) : Get.toNamed(Routes.adsView);
      } else {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Enter your passcode');
      }
    } on Failure catch (ex) {
      if (ex.message.contains('Account not verified')) {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Account not verified');
        Get.to(() => OTPVerification(fromSignUp: true));
      } else if (ex.message.contains('Wrong Passcode')) {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Incorrect Passcode!!!');
      } else {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Something went wrong, please try again later.');
      }
    }
  }

  Future<void> createTransactionPIN() async {
    try {
      Loader.showLoader();
      // await _authenticationService.createTransactionPIN(
      //   transactionPin: int.parse(_transactionPIN!),
      // );
      Get.back();
      SnackbarUtil.showSnackbar('Account secured successfully.');
      // Get.toNamed(Routes.signUpSuccessView);
    } on Failure {
      Get.back();
      SnackbarUtil.showErrorSnackbar('Something went wrong, please try again later.');
    }
  }

  Future<void> passwordResetOTP() async {
    try {
      Loader.showLoader();
      // await _authenticationService.passwordResetOTP(
      //   phoneNumber: _phoneNumber!,
      //   otpMethod: _otpMethodSMS!,
      // );
      Get.back();
      Get.to(() => OTPVerification(fromSignUp: false));
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> passwordReset() async {
    try {
      Loader.showLoader();
      if (_password == _confirmPassword) {
        // await _authenticationService.passwordReset(
        //   phoneNumber: _phoneNumber!,
        //   password: _password!,
        //   passwordConfirmation: _confirmPassword!,
        // );
        Get.back();
        SnackbarUtil.showSnackbar('Password reset successful.');
        // Get.offAllNamed(Routes.loginView);
      } else {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Password does not match.');
      }
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> resendOTP() async {
    try {
      Loader.showLoader();
      // await _authenticationService.resendOTP(
      //   phoneNumber: _phoneNumber!,
      //   otpMethod: _otpMethodSMS!,
      // );
      Get.back();
      Get.to(() => OTPVerification(fromSignUp: true));
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> initiateWithdrawMoney() async {
    try {
      Loader.showLoader();
      // _fee = await _authenticationService.initiateWithdraw(
      //   amount: CurrencyUtil.getAmount(_withdrawAmount!),
      //   isTransferDetails: 'true',
      //   depositAccountID: listBankAccounts[listBankAccounts.length - 1]['id'].toString(),
      // );
      Get.back();
      Get.back();
      Get.to(() => const WithdrawalConfirmation());
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> withdrawMoney() async {
    try {
      Loader.showLoader();
      // var _withdrawalResponse = await _authenticationService.withdraw(
      //   amount: CurrencyUtil.getAmount(_withdrawAmount!),
      //   isTransferDetails: 'false',
      //   depositAccountID: listBankAccounts[listBankAccounts.length - 1]['id'].toString(),
      // );
      // var _verifyStatus = await _authenticationService.verifyWithdrawal(
      //   transferID: _withdrawalResponse[0],
      //   reference: _withdrawalResponse[1],
      // );
      Get.back();
      Get.offAll(() => WithdrawalSuccess(
            title: 'Success!',
            message:
                "You've successfully transferred #${CurrencyUtil.formatCurrency(double.parse(totalAmount!.toString()))}\n to ${listBankAccounts[listBankAccounts.length - 1]['account_name']!} via WithHalal - Bank Transfer.",
          ));
      // SnackbarUtil.showErrorSnackbar(_verifyStatus.toString());
    } on Failure catch (ex) {
      if (ex.message == 'Transfer pending, please do not retry the transfer') {
        Get.back();
        Future.delayed(30.seconds);
        Get.offAll(() => const WithdrawalSuccess(
              title: 'Transaction Pending',
              message: "Withdrawal pending, please do not retry the process.",
            ));
      } else {
        Get.back();
        Get.offAll(() => const WithdrawalSuccess(
              title: 'Transaction Failed',
              message: "Withdrawal failed, try again later.",
            ));
      }
      await getWalletBalance();
    }
  }

  Future<void> signOut() async {
    Loader.showLoader();
    // await _authenticationService.signOut();
    Get.back();
    // Get.offAllNamed(Routes.loginView);
  }

  Future<void> getWalletBalance() async {
    try {
      // _walletBalance = await _authenticationService.getWalletBalance();
      update();
    } on Failure {
      // SnackbarUtil.showErrorSnackbar('Confirm your device is connected to the internet.');
    }
  }

  Future<User?> getUser() async {
    // _user = await _authenticationService.getUser();
    update();
    return _user;
  }

  Future<void> fundWithCard() async {
    try {
      Loader.showLoader();
      // _fundWalletResponse = await _authenticationService.fundWithCard(
      //   amount: CurrencyUtil.getAmount(_fundAmount!),
      // );
      _authURL = _fundWalletResponse[0];
      _reference = _fundWalletResponse[1];
      // Get.back();
      Get.back();
      Get.to(() => CustomWebView(
            url: _authURL!,
            reference: _reference!,
          ));
    } on Failure catch (ex) {
      if (ex.message.contains('Payment already made')) {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Payment already made, refresh balance.');
        // Get.offAllNamed(Routes.homeView);
      } else {
        Get.back();
        SnackbarUtil.showErrorSnackbar('Something went wrong, please try again later.');
      }
    }
  }

  Future<void> getBankAccount() async {
    try {
      // var _userBankAccounts = await _authenticationService.getBankAccount();
      // _listBankAccounts = _userBankAccounts[3];
    } on Failure {
      // SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  void timerStart() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_timeCount > 0) {
          _timeCount--;
          // print(_timeCount);
          update();
        } else {
          // print(_timeCount);
          _timer.cancel();
        }
      },
    );
  }

  Future<String> getDeviceIdentifier() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceIdentifier = '${androidInfo.model}-${androidInfo.brand}-${androidInfo.id}';
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceIdentifier = iosInfo.identifierForVendor!;
    }
    return _deviceIdentifier;
  }

  Future<void> getAds() async {
    try {
      // _ads = await _authenticationService.fetchAds();
      update();
    } on Failure {
      // setState(ErrorState(message: ex.message));
    }
  }
}

class VerifyOtpScreenArguments {
  final String? identifier;
  final String? phoneNumber;
  final bool isFromLogin;

  VerifyOtpScreenArguments(this.identifier, this.phoneNumber, this.isFromLogin);
}
