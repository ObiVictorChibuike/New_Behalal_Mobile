class ApiPaths {
  //Base URL
  static const String baseUrl = "http://halal-coreapi-development-0f83f45e879c.herokuapp.com";

//auth
  static const String authSignUp = "/api/v1/user/register";
  static const String authLogin = "/api/v1/user/login";
  static const String resetPassword = "/api/forgot_password";
  static const String verifyRegistrationOtp = "/api/v1/user/validate-new-user-otp";
  static const String resendOtp = "/api/v1/user/resend-new-user-otp";
  static const String setUpPasscode = "/api/v1/user/passcode-setup";
  static const String verifyLoginPhone = "/api/v1/user/validate-2fa-otp";
  static const String resendLoginOtp = "/api/v1/user/validate-2fa-otp";
  static const String userDetailsPassword = "/api/v1/user/new-user-detail-password";


  //DashBoard
  static const String dashboardProfile = "/api/v1/user/dashboard";

  //Bills
  static const String airTime = "/api/v1/bills/billers/airtime";
  static const String cableTv = "/api/v1/bills/billers/cable-tv";
  static const String utility = "/api/v1/bills/billers/utility";
  static const String data = "/api/v1/bills/billers/data";
  static const String electricity = "/api/v1/bills/billers/electricity";
  static const String billById = "/api/v1/bills/billers-payment-item/";
  static const String dataById = "/api/v1/bills/billers-payment-item/";
  static const String getAllBeneficiary = "/api/v1/bills/beneficiary";
  static const String purchaseAirtime = "/api/v1/bills/airtime-top-up";
  static const String addBeneficiary = "/api/v1/bills/beneficiary";
}
