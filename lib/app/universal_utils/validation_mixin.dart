

import 'package:behalal/app/universal_utils/currency_util.dart';
import 'package:intl_phone_field/phone_number.dart';

mixin ValidationMixin {
  String? validateNotEmpty(String? value) => value != null && value.isEmpty ? 'Field cannot be empty' : null;

  String? validateFullName(String? fullName) {
    if (fullName != null && fullName.isEmpty) {
      return 'Fullname field cannot be empty';
    }

    if (fullName != null && fullName.split(' ').length < 2) {
      return 'Fullname field should contain first and last name';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email != null) {
      if (email.isEmpty) return 'Email field cannot be empty';
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      if (!emailValid) return 'Enter a Valid Email Address';
    }
    return null;
  }

  String? validateFundingAmount(String? value) {
    if (value != null) {
      if (value.isEmpty) return 'Field cannot be empty';
      if (int.parse(CurrencyUtil.getAmount(value)) < 100) return 'Amount must be more than 100';
    }
    return null;
  }

  String? validateAirtimeFunding(String? value) {
    if (value != null) {
      if (value.isEmpty) return 'Field cannot be empty';
      if (int.parse(CurrencyUtil.getAmount(value)) < 50) return 'Airtime amount must be more than 50';
    }
    return null;
  }

  // String? validatePhoneNumber(String? phoneNumber) {
  //   if ((phoneNumber != null && phoneNumber.length < 10)) {
  //     return 'Enter a Valid Phone Number';
  //   }
  //   if (phoneNumber != null && phoneNumber.length != 11) {
  //     return 'Enter a Valid Phone Number';
  //   }
  //   return null;
  // }

  String? validatePhoneNumber(PhoneNumber? phoneNumber) {
    if ((phoneNumber != null && phoneNumber.number.length < 10)) {
      return 'Enter a Valid Phone Number';
    }
    if (phoneNumber != null && phoneNumber.number.length != 11) {
      return 'Enter a Valid Phone Number';
    }
    return null;
  }

  String? validateAccountNumber(String? acctNo) {
    if (acctNo != null && acctNo.length < 10) {
      return 'Enter a Valid Account Number';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password != null) {
      if (password.isEmpty) return 'Password field cannot be empty';
      if (password.length < 6) return 'Please field should be greater than 6';
    }
    return null;
  }

  String? validatePasscode(String? password) {
    if (password != null) {
      if (password.isEmpty) return 'Passcode field cannot be empty';
      if (password.length != 4) return 'Please field should be 4 digits';
    }
    return null;
  }

  String? validatePasswordStrict(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return 'Password field cannot be empty';
      }
      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasMinLength = password.length > 8;
      if (hasDigits & hasUppercase & hasLowercase & hasMinLength) return null;
    }
    return 'Please enter a valid password';
  }

  String? validateDate(String? date) {
    if (date != null && date.isEmpty) {
      return 'Date field cannot be empty';
    }
    return null;
  }

  String? validatePin(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return 'Pin field cannot be empty';
      }
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasMinLength = password.length > 6;
      if (hasDigits & !hasLowercase & hasMinLength) return null;
    }
    return 'Please enter a valid pin';
  }

  String? validateTransactionPin(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return 'Pin field cannot be empty';
      }
      bool hasMinLength = password.length >= 6;
      if (hasMinLength) return null;
    }
    return 'Please enter a valid pin';
  }
}
