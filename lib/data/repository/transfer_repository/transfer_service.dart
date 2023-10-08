

import 'package:behalal/data/models/transfer_models/banks_list_model.dart';

abstract class TransferService {
  Future<void> p2pTransfer({
    required int phoneNumber,
    required String reason,
    required int amount,
    required bool anon,
    required int pin,
  });

  Future<List<String>> getOtherUserDetails({
    required int phoneNumber,
  });

  Future<BanksListResponse> getBanksList();

  Future<String> verifyBankAccount({
    required String accountNumber,
    required String bankCode,
  });

  Future<String> verifyTransaction({
    required String transferID,
    required String reference,
  });

  Future<List<String>> bankTransfer({
    required String accountNumber,
    required String bankName,
    required int amount,
    required String isTransferDetails,
    required String description,
    required int pin,
  });

    Future<String> initiateBankTransfer({
    required String accountNumber,
    required String bankName,
    required int amount,
    required String isTransferDetails,
    required String description,
  });
}
