import 'package:behalal/app/universal_utils/currency_util.dart';
import 'package:behalal/app/universal_utils/loader.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/universal_utils/state_notifier.dart';
import 'package:behalal/app/universal_utils/validation_mixin.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/data/models/failure_models/failure.dart';
import 'package:behalal/presentation/transfers/confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferController extends StateNotifier with ValidationMixin {
  // final _transferService = Get.put<TransferService>(TransferServiceImpl());

  TextEditingController pinCodeController = TextEditingController();
  final nameController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();
    await _getBanksList();
  }

  // @override
  // void dispose() {
  // nameController.text;
  //   super.dispose();
  // }

  String? _phoneNumber = '';
  String? _accountNumber = '';
  String? _amount = '0';
  String? _accountName = '';
  String? _photoURL = '';
  String? _bankName = '';
  String? _bankCode = '';
  String? _fee = '0';
  int? _pin;
  String? _reason = '';
  bool _sendAnon = false;
  List<String?> _userDetailsResponse = [];
  List<String>? _bankNames = [];
  List<String>? _bankCodes = [];

  String? get phoneNumber => _phoneNumber;
  String? get accountNumber => _accountNumber;
  String? get amount => _amount;
  String? get reason => _reason;
  String? get fee => _fee;
  String? get bankCode => _bankCode;
  String? get photoURL => _photoURL;
  String? get bankName => _bankName;
  double? get totalAmount => double.parse(_fee!) + double.parse(CurrencyUtil.getAmount(_amount!));
  bool get acceptTerms => _sendAnon;
  String? get accountName => _accountName;
  String? get walletBalance => _authController.walletBalance;
  List<String> get bankNames => _bankNames!;

  void onBankNameChanged(String? value) async {
    _bankName = value;
    var _nameIndex = _bankNames!.indexWhere((item) => item.contains(value!));
    _bankCode = _bankCodes![_nameIndex];
    _bankName = _bankNames![_nameIndex];
    nameController.clear();
    _accountNumber = '';
    update();
  }

  void onPhoneNumberChanged(String? value) async {
    _phoneNumber = value;
    nameController.text = '';
    value!.length > 10 ? await _getPhoneNumberDetail() : Null;
    update();
  }

  void onAccountNumberChanged(String? value) async {
    _accountNumber = value;
    nameController.text = '';
    update();
    value!.length == 10 ? await verifyBankAccount(acctNo: value) : Null;
    update();
  }

  void onAmountChanged(String? value) {
    _amount = value;
    update();
  }

  void onReasonChanged(String? value) {
    _reason = value;
    update();
  }

  void sendAnon(value) {
    _sendAnon = value;
    update();
  }

  void onPINChanged(int? value) {
    _pin = value;
    update();
  }

  Future<void> p2pTransfer() async {
    try {
      Loader.showLoader();
      // await _transferService.p2pTransfer(
      //   phoneNumber: int.parse(_phoneNumber!),
      //   anon: _sendAnon,
      //   reason: _reason!,
      //   amount: int.parse(CurrencyUtil.getAmount(_amount!)),
      //   pin: _pin!,
      // );
      await _authController.getWalletBalance();
      _sendAnon = false;
      Get.back();
      Get.offAll((() => TransactionSuccess(
            amount: CurrencyUtil.getAmount(amount!.toString()),
            destination: _accountName!,
            message: 'Success!',
            title:
                "You've successfully transferred #${CurrencyUtil.formatCurrency(double.parse(CurrencyUtil.getAmount(amount!.toString()).toString()))}\n to ${_accountName!} via WithHalal P2P.",
          )));
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);

      // Get.offAll(() => TransactionSuccess(
      //       amount: CurrencyUtil.getAmount(totalAmount!.toString()),
      //       destination: _accountName!,
      //       message: 'Transaction Failed',
      //       title: "Transaction failed, try again later.",
      //     ));
      await _authController.getWalletBalance();
    }
  }

  Future<void> bankTransfer() async {
    try {
      Loader.showLoader();
      // var _response = await _transferService.bankTransfer(
      //   accountNumber: _accountNumber!,
      //   amount: int.parse(CurrencyUtil.getAmount(_amount!)),
      //   bankName: _bankCode!,
      //   description: reason!,
      //   isTransferDetails: 'false',
      //   pin: _pin!,
      // );
      // var _verifyStatus = await _transferService.verifyTransaction(
      //   transferID: _response[0],
      //   reference: _response[1],
      // );
      Get.back();
      Get.offAll(() => TransactionSuccess(
            amount: CurrencyUtil.getAmount(totalAmount!.toString()),
            destination: _accountName!,
            message: 'Success!',
            title:
                "You've successfully transferred #${CurrencyUtil.formatCurrency(double.parse(totalAmount!.toString()))}\n to ${_accountName!} via WithHalal - Bank Transfer.",
          ));
      await _authController.getWalletBalance();
    } on Failure catch (ex) {
      if (ex.message == 'Transfer pending, please do not retry the transfer') {
        Future.delayed(30.seconds);
        Get.offAll(() => TransactionSuccess(
              amount: CurrencyUtil.getAmount(totalAmount!.toString()),
              destination: _accountName!,
              message: 'Transaction Pending',
              title: "Transfer pending, please do not retry the transfer",
            ));
      } else {
        Get.back();
        Get.offAll(() => TransactionSuccess(
              amount: CurrencyUtil.getAmount(totalAmount!.toString()),
              destination: _accountName!,
              message: 'Transaction Failed',
              title: "Transaction failed, try again later.",
            ));
      }
      await _authController.getWalletBalance();
    }
  }

  Future<void> initiateBankTransfer() async {
    try {
      Loader.showLoader();
      //_fee = await _transferService.initiateBankTransfer(
      //   accountNumber: _accountNumber!,
      //   amount: int.parse(CurrencyUtil.getAmount(_amount!)),
      //   bankName: _bankCode!,
      //   description: reason!,
      //   isTransferDetails: 'true',
      // );
      Get.back();
      Get.to(() => const TransactionConfirmation(
            from: 'BANK',
          ));
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> _getPhoneNumberDetail() async {
    try {
      Loader.showLoader();
      //_userDetailsResponse = await _transferService.getOtherUserDetails(phoneNumber: int.parse(_phoneNumber!));
      _accountName = _userDetailsResponse[0];
      nameController.text = _accountName!;
      _photoURL = _userDetailsResponse[1];
      update();
      Get.back();
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> _getBanksList() async {
    try {
      //var _getBanksList = await _transferService.getBanksList();
     // var _banksList = _getBanksList.banksList;
     //  _bankNames = _banksList?.map((x) => x.name.toString()).cast<String>().toList();
     //  _bankCodes = _banksList?.map((x) => x.code.toString()).cast<String>().toList();
     //  _bankName = _bankNames?[0];
      update();
    } on Failure {
      // Get.back();
      // SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> verifyBankAccount({required String acctNo}) async {
    try {
      Loader.showLoader();
      //_accountName = await _transferService.verifyBankAccount(accountNumber: acctNo, bankCode: _bankCode!);
      nameController.text = _accountName!;
      _photoURL = 'null';
      update();
      Get.back();
    } on Failure catch (ex) {
      Get.back();
      _accountName = '';
      update();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }
}
