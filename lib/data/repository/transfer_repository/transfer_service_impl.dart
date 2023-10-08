// import 'dart:developer';
// import 'transfer_service.dart';
// import 'package:get/get.dart';
//
// class TransferServiceImpl extends NetworkServiceImol implements TransferService {
//   final _tokenService = Get.find<TokenService>();
//
//   @override
//   Future<void> p2pTransfer({
//     required int phoneNumber,
//     required String reason,
//     required bool anon,
//     required int amount,
//     required int pin,
//   }) async {
//     final uri = anon ? getAPI.p2pAnonTransferUri : getAPI.p2pTransferUri;
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         "phonenumber": phoneNumber.toString(),
//         "amount": amount.toString(),
//         "reason": reason,
//         "transaction_pin": pin.toString(),
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     return response['message'];
//   }
//
//   @override
//   Future<List<String>> bankTransfer({
//     required String accountNumber,
//     required String bankName,
//     required int amount,
//     required String isTransferDetails,
//     required String description,
//     required int pin,
//   }) async {
//     final uri = getAPI.bankTransferUri;
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         "account_bank": bankName,
//         "account_number": accountNumber,
//         "amount": amount.toString(),
//         "is_transfer_details": isTransferDetails,
//         "description": description,
//         "transaction_pin": pin.toString(),
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     int _transferID = response['transfer_id'];
//     String _reference = response['reference'];
//     return [_transferID.toString(), _reference];
//   }
//
//   @override
//   Future<String> initiateBankTransfer({
//     required String accountNumber,
//     required String bankName,
//     required int amount,
//     required String isTransferDetails,
//     required String description,
//   }) async {
//     final uri = getAPI.bankTransferUri;
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         "account_bank": bankName,
//         "account_number": accountNumber,
//         "amount": amount.toString(),
//         "is_transfer_details": isTransferDetails,
//         "description": description,
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     double _fee = response['fee'];
//     return _fee.toString();
//   }
//
//   @override
//   Future<String> verifyBankAccount({
//     required String accountNumber,
//     required String bankCode,
//   }) async {
//     final uri = getAPI.verifyBankAccountUri;
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         "account_bank": bankCode,
//         "account_number": accountNumber.toString(),
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     return response['data']['account_name'];
//   }
//
//   @override
//   Future<String> verifyTransaction({
//     required String transferID,
//     required String reference,
//   }) async {
//     final hostUri = getAPI.host;
//     final uri = Uri.https(hostUri, "/api/v1/individual/bank-transfer-callback/$reference/$transferID");
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         // "reference": reference,
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     return response['message'];
//   }
//
//   @override
//   Future<BanksListResponse> getBanksList() async {
//     final uri = getAPI.getBanksListUri;
//     final token = await _tokenService.getToken();
//     final response = await get(
//       uri,
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     return BanksListResponse.fromJson(response);
//   }
//
//   @override
//   Future<List<String>> getOtherUserDetails({required int phoneNumber}) async {
//     final uri = getAPI.otherUserDetailUri;
//     final token = await _tokenService.getToken();
//     final response = await post(
//       uri,
//       body: {
//         "phonenumber": phoneNumber.toString(),
//       },
//       headers: {"Authorization": getAPI.authorizationValue(token.value)},
//     );
//     String _usersName = '${response['first_name']} ${response['last_name']}';
//     String _photoURL = response['photo_url'].toString();
//     return [_usersName, _photoURL];
//   }
// }
