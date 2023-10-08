import 'dart:convert';

import 'package:behalal/app/constants/api_path.dart';
import 'package:behalal/core/network/dio_core/dio_client.dart';
import 'package:behalal/core/network/dio_core/dio_error.dart';
import 'package:behalal/data/models/auth_models/login/login_request.dart';
import 'package:behalal/data/models/auth_models/registration/registration_request_model_response.dart';
import 'package:behalal/data/models/auth_models/user_details/user_details_request_model.dart';
import 'package:behalal/data/models/auth_models/verify_otp/verify_otp_request_model_response.dart';
import 'package:behalal/data/models/passcode_models/create_passcode_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class AuthenticationServiceImpl extends AuthenticationService {
  final NetworkProvider _networkProvider = NetworkProvider();
  // @override
  // Future<void> createTransactionPIN({
  //   required int transactionPin,
  // }) async {
  //   final uri = getAPI.createTransactionPINUri;
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       "transaction_pin": transactionPin.toString(),
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   log("create transaction pin impl ::: ${response.toString()}");
  // }
  //
  // @override
  // Future<User?> getUser() async {
  //   final tokenString = await _tokenService.getAuthToken();
  //   if (tokenString != null) {
  //     final token = Token.fromJson(json.decode(tokenString));
  //     return await _getAuthenticatedUser(token: token.value);
  //   }
  //   return null;
  // }
  //
  // @override
  // Future<String?> getWalletBalance() async {
  //   final uri = getAPI.getWalletBalanceUri;
  //   final token = await _tokenService.getToken();
  //   final response = await get(
  //     uri,
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   // log('wallet balance ::: ${response['wallet_balance'].toString()}');
  //   return response['wallet_balance'];
  // }

  @override
  Future<Response<dynamic>?> login({
    required LoginRequestModelResponse loginRequestModelResponse
  }) async {
    try{
      var body = loginRequestModelResponse.toJson();
      var response = await _networkProvider.call(path: ApiPaths.authLogin, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> register({required RegistrationRequestModelResponse registrationRequestModelResponse}) async{
    try{
      var body = registrationRequestModelResponse.toJson();
      var response = await _networkProvider.call(path: ApiPaths.authSignUp, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> verifyOTP({required VerifyOtpRequestModelResponse verifyOtpRequestModelResponse}) async{
    try{
      var body = verifyOtpRequestModelResponse.toJson();
      var response = await _networkProvider.call(path: ApiPaths.verifyRegistrationOtp, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> resendUserOtp({required String identifier}) async{
    try{
      var body = jsonEncode({
        "identifier": identifier
      });
      var response = await _networkProvider.call(path: ApiPaths.resendOtp, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> setPassCode({required CreatePasscodeRequestModel createPasscodeRequestModel}) async{
    try{
      var body = createPasscodeRequestModel.toJson();
      var response = await _networkProvider.call(path: ApiPaths.verifyRegistrationOtp, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> verifyPhoneNumber({required String otp}) async{
    try{
      var body = jsonEncode({
        "otp": otp
      });
      var response = await _networkProvider.call(path: ApiPaths.verifyLoginPhone, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response<dynamic>?> resendUserLoginOtp() async{
    try{
      var response = await _networkProvider.call(path: ApiPaths.resendLoginOtp, method: RequestMethod.get,);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<Response?> createUserDetails({required UserDetailsRequestResponseModel userDetailsRequestResponseModel}) async{
    try{
      var body = userDetailsRequestResponseModel.toJson();
      var response = await _networkProvider.call(path: ApiPaths.userDetailsPassword, method: RequestMethod.post, body: body);
      return response;
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  // @override
  // Future<void> passwordReset({
  //   required String phoneNumber,
  //   required String password,
  //   required String passwordConfirmation,
  // }) async {
  //   final uri = getAPI.changePasswordUri;
  //   final response = await post(
  //     uri,
  //     body: {
  //       "phonenumber": phoneNumber,
  //       "password": password,
  //       "password_confirmation": passwordConfirmation,
  //     },
  //   );
  //   // log('reset password impl ::: $response');
  // }
  //
  // @override
  // Future<void> passwordResetOTP({
  //   required String phoneNumber,
  //   required String otpMethod,
  // }) async {
  //   final uri = getAPI.resetPasswordUri;
  //   final response = await post(
  //     uri,
  //     body: {
  //       "phonenumber": phoneNumber,
  //       "otp_method": otpMethod,
  //     },
  //   );
  //   // log('reset password impl ::: $response');
  // }
  //
  // @override
  // Future<List<String>> fundWithCard({
  //   required String amount,
  // }) async {
  //   final uri = getAPI.flutterwaveFundWithCardUri; //getAPI.paystackFundWithCardUri;
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       "top_amount": amount,
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   // log('fund impl ::: $response');
  //   String _authURL = response['data']['link'];
  //   String _reference = response['message'];
  //   return [_authURL, _reference];
  // }
  //
  // @override
  // Future<String> initiateWithdraw({
  //   required String amount,
  //   required String isTransferDetails,
  //   required String depositAccountID,
  // }) async {
  //   final hostUri = getAPI.host;
  //   final uri = Uri.https(hostUri, "/api/v1/individual/withdraw-funds-halal/$depositAccountID");
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       "amount": amount,
  //       "is_transfer_details": isTransferDetails,
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   // log('withdraw impl ::: $response');
  //   String fee = response['fee'].toString();
  //   // String _reference = response['reference'];
  //   return fee;
  // }
  //
  // @override
  // Future<List<String>> withdraw({
  //   required String amount,
  //   required String isTransferDetails,
  //   required String depositAccountID,
  // }) async {
  //   final hostUri = getAPI.host;
  //   final uri = Uri.https(hostUri, "/api/v1/individual/withdraw-funds-halal/$depositAccountID");
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       "amount": amount,
  //       "is_transfer_details": isTransferDetails,
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   String _transferID = response['transfer_id'].toString();
  //   String _reference = response['reference'].toString();
  //   return [_transferID, _reference];
  // }
  //
  // @override
  // Future<String> verifyWithdrawal({
  //   required String transferID,
  //   required String reference,
  // }) async {
  //   final hostUri = getAPI.host;
  //   final uri = Uri.https(hostUri, "/api/v1/individual/bank-transfer-callback/$reference/$transferID");
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       // "reference": reference,
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   return response['message'];
  // }
  //
  // @override
  // Future<String> verifyFundWithCard({
  //   required String reference,
  // }) async {
  //   final hostUri = getAPI.host;
  //   final uri = Uri.https(hostUri, "/api/v1/individual/verify-fund-wallet-paystack/$reference");
  //   final token = await _tokenService.getToken();
  //   final response = await post(
  //     uri,
  //     body: {
  //       // "reference": reference,
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   return response['message'];
  // }
  //
  // @override
  // Future<void> register({
  //   required String cooperativeSocietyName,
  //   required String firstName,
  //   required String lastName,
  //   required String otpMethod,
  //   required String password,
  //   required String phoneNumber,
  //   required String deviceId,
  //   String? referalCode,
  // }) async {
  //   final uri = getAPI.signUpUri;
  //   final response = await post(
  //     uri,
  //     body: {
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "password": password,
  //       "phonenumber": phoneNumber,
  //       "cooperative_society_name": cooperativeSocietyName,
  //       "otp_method": otpMethod,
  //       "device_id": deviceId,
  //       "referrer_code": referalCode,
  //     },
  //   );
  //   // log("auth service impl ${response.toString()}");
  // }
  //
  // @override
  // Future<void> resendOTP({
  //   required String phoneNumber,
  //   required String otpMethod,
  // }) async {
  //   final uri = getAPI.resendOTPUri;
  //   final response = await post(
  //     uri,
  //     body: {
  //       "phonenumber": phoneNumber,
  //       "otp_method": otpMethod,
  //     },
  //   );
  //   // log('resend otp impl ::: $response');
  // }
  //
  // @override
  // Future<void> signOut() async {
  //   await _tokenService.deleteToken();
  // }
  //
  // @override
  // Future<User?> verifyOTP({
  //   required int otpCode,
  //   required bool fromSignUp,
  // }) async {
  //   final uri = fromSignUp ? getAPI.otpVerificationUri : getAPI.passwordResetOTPUri;
  //   final response = await post(
  //     uri,
  //     body: {
  //       "otp": otpCode.toString(),
  //     },
  //   );
  //   if (fromSignUp) {
  //     await _tokenService.saveToken(json.encode(response));
  //     final token = Token.fromJson(response);
  //     return await _getAuthenticatedUser(token: token.value);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // @override
  // Future<List<dynamic>> getBankAccount() async {
  //   final uri = getAPI.getDepositBankAccounts;
  //   final token = await _tokenService.getToken();
  //   final response = await get(
  //     uri,
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   List<dynamic> responseData = response['benefeciaries'];
  //   String _acctName = responseData.isNotEmpty ? responseData[responseData.length - 1]['account_name'] : '';
  //   String _bankName = responseData.isNotEmpty ? responseData[responseData.length - 1]['bank_name'] : '';
  //   String _acctNo = responseData.isNotEmpty ? responseData[responseData.length - 1]['account_number'] : '';
  //   return [_acctName, _bankName, _acctNo, responseData];
  // }
  //
  // // @override
  // // Future<void> welcomeBack({
  // //   required int passCode,
  // // }) async {
  // //   final uri = getAPI.passcodeAuthUri;
  // //   final token = await _tokenService.getToken();
  // //   await post(
  // //     uri,
  // //     body: {
  // //       "passcode": passCode.toString(),
  // //     },
  // //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  // //   );
  // // }
  //
  // @override
  // Future<void> welcomeBack({
  //   required int passCode,
  // }) async {
  //   final uri = getAPI.verifyTransactionPinUri;
  //   final token = await _tokenService.getToken();
  //   await post(
  //     uri,
  //     body: {
  //       "transaction_pin": passCode.toString(),
  //     },
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  // }
  //
  // Future<User> _getAuthenticatedUser({required String token}) async {
  //   final uri = getAPI.getUserUri;
  //   final response = await get(
  //     uri,
  //     headers: {"Authorization": getAPI.authorizationValue(token)},
  //   );
  //   // log('authenticated user profile ::: ${response.toString()}');
  //   return User.fromJson(response);
  // }
  //
  // @override
  // Future<List<Ad>?> fetchAds() async {
  //   final uri = getAPI.getAdsUri;
  //   final token = await _tokenService.getToken();
  //   final response = await get(
  //     uri,
  //     headers: {"Authorization": getAPI.authorizationValue(token.value)},
  //   );
  //   // log('adssss ::: ${response.toString()}');
  //   return AdResponse.fromJson(response).ads;
  // }
}
