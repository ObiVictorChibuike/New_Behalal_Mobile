import 'package:behalal/data/models/auth_models/login/login_request.dart';
import 'package:behalal/data/models/auth_models/registration/registration_request_model_response.dart';
import 'package:behalal/data/models/auth_models/user_details/user_details_request_model.dart';
import 'package:behalal/data/models/auth_models/verify_otp/verify_otp_request_model_response.dart';
import 'package:behalal/data/models/passcode_models/create_passcode_request_model.dart';
import 'package:dio/dio.dart';


abstract class AuthenticationService {
  Future<Response<dynamic>?> login({
    required LoginRequestModelResponse loginRequestModelResponse,
  });
  Future<Response<dynamic>?> resendUserOtp({
    required String identifier,
  });

  Future<Response<dynamic>?> resendUserLoginOtp();

  Future<void> verifyPhoneNumber({
    required String otp,
  });
  Future<Response<dynamic>?> register({
    required RegistrationRequestModelResponse registrationRequestModelResponse,
  });
  Future<Response<dynamic>?> verifyOTP({
    required VerifyOtpRequestModelResponse verifyOtpRequestModelResponse,
  });
  Future<Response<dynamic>?> setPassCode({
    required CreatePasscodeRequestModel createPasscodeRequestModel,
  });
  Future<Response<dynamic>?> createUserDetails({
    required UserDetailsRequestResponseModel userDetailsRequestResponseModel,
  });

  // Future<void> passwordResetOTP({
  //   required String phoneNumber,
  //   required String otpMethod,
  // });
  //
  // Future<void> passwordReset({
  //   required String phoneNumber,
  //   required String password,
  //   required String passwordConfirmation,
  // });
  //
  // Future<void> resendOTP({
  //   required String phoneNumber,
  //   required String otpMethod,
  // });
  //
  // Future<List<String>> fundWithCard({
  //   required String amount,
  // });
  //
  // Future<String> verifyFundWithCard({
  //   required String reference,
  // });
  //
  // Future<String> initiateWithdraw({
  //   required String amount,
  //   required String isTransferDetails,
  //   required String depositAccountID,
  // });
  //
  // Future<String> verifyWithdrawal({
  //   required String transferID,
  //   required String reference,
  // });
  //
  // Future<List<String>> withdraw({
  //   required String amount,
  //   required String isTransferDetails,
  //   required String depositAccountID,
  // });
  //
  // Future<List<Ad>?> fetchAds();
  //
  // Future<void> signOut();
  //
  // Future<String?> getWalletBalance();
  //
  // Future<User?> getUser();
  //
  // Future<List<dynamic>> getBankAccount();
}
