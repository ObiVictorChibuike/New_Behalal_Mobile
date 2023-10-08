import 'package:behalal/app/universal_utils/loader.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/universal_utils/state_notifier.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/data/models/failure_models/failure.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionController extends StateNotifier {
  final _authController = Get.find<AuthController>();
  final List<String> repeat = [
    'Credit',
    'Debit',
  ];

  bool _filtered = false;
  String? _fromDate;
  int? _selectedType = 1;
  String? _toDate;
  // final _transactionService = Get.put<TransactionService>(TransactionServiceImpl());
  // List<Transaction>? _transactions;
  // TransactionDetailsModel? _transactionDetails;
  // List<TransactionFilter>? _transactionsFilter;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getTransactions();
  // }
  //
  // List<Transaction>? get transactions => _transactions?.reversed.toList();
  // List<TransactionFilter>? get transactionsFilter => _transactionsFilter?.reversed.toList();
  // TransactionDetailsModel? get transactionsDetails => _transactionDetails;
  // bool get filtered => _filtered;
  // int? get selectedType => _selectedType;
  // String? get fromDate => _fromDate;
  // String? get toDate => _toDate;

  void onSelectedTypeChanged(int? value) {
    _selectedType = value;
    update();
  }

  void onFromDateChanged(DateTime value) {
    _fromDate = DateFormat('yyyy-MM-dd').format(value).toString();
    Get.back();
    update();
  }

  void onToDateChanged(DateTime value) {
    _toDate = DateFormat('yyyy-MM-dd').format(value).toString();
    Get.back();
    update();
  }

  Future<void> getTransactions() async {
    setState(LoadingState());
    try {
      // _transactions = await _transactionService.getTransactions();
      // _authController.getWalletBalance();
      setState(IdleState());
    } on Failure catch (ex) {
      setState(ErrorState(message: ex.message));
    }
  }

  Future<void> getTransactionDetails({required String transactionID}) async {
    Loader.showLoader();
    try {
     // _transactionDetails = await _transactionService.getTransactionDetails(transactionID: transactionID);
      Get.back();
      // Get.to(() => TransactionDetails(transaction: _transactionDetails));
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> filterTransactions() async {
    _filtered = true;
    try {
      Get.back();
      Loader.showLoader();
      // _transactionsFilter = await _transactionService.transactionFilter(
      //     from: _fromDate ?? DateTime(2020 - 01 - 01).toString(),
      //     to: _toDate ?? DateTime(2035 - 01 - 01).toString(),
      //     type: _selectedType != null
      //         ? _selectedType == 0
      //             ? 'credit'
      //             : 'debit'
      //         : 'debit');
      Get.back();
      update();
    } on Failure catch (ex) {
      Get.back();
      SnackbarUtil.showErrorSnackbar(ex.message);
    }
  }

  Future<void> clearFilter() async {
    Get.back();
    Loader.showLoader();
    Future.delayed(const Duration(seconds: 1), () {
      _filtered = false;
      update();
      Get.back();
    });
  }
}
