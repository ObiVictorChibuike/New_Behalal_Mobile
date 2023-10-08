import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/universal_utils/validation_mixin.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/pin_code.dart';
import 'package:behalal/app/widgets/pincode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class SavingController extends GetxController with ValidationMixin{
  final controller = GroupButtonController();
  final planNameController = TextEditingController();
  final amountController = TextEditingController();
  final pinController = TextEditingController();
  final savings = [
    {
      "title": "Backup Money",
      "savings_type": "Spend To Save",
      "buttonLabel": "Trigger",
      "amount": "10% on Bank Deposits",
      "balanceLabel": "Current Balance",
      "balance": "₦ 12,640.20",
    },
    {
      "title": "School Resumption",
      "savings_type": "Target Savings",
      "buttonLabel": "Target Amount",
      "amount": "₦2,300,000.00",
      "balanceLabel": "Current Balance",
      "balance": "₦ 12,640.20",
    },
    {
      "title": "Trip to Rwanda",
      "savings_type": "Save Small Small",
      "buttonLabel": "Current Savings",
      "amount": "₦ 12,640.20",
      "balanceLabel": "Target Amount",
      "balance": "₦ 12,640.20",
    },
    {
      "title": "Hajj 2024",
      "savings_type": "Save Small Small",
      "buttonLabel": "Current Savings",
      "amount": "₦ 12,640.20",
      "balanceLabel": "Target Amount",
      "balance": "₦ 12,640.20",
    },
  ];

  String? _planName;

  void onPlanNameChanged(String value) {
    _planName = value;
    update();
  }

  void numberPadDialog({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
      horizontalPadding: 0, verticalPadding: 0,
        context: context, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 35, fontWeight: FontWeight.w700, color: AppColors.black),
          controller: pinController,
          decoration: InputDecoration(hintText: "₦0.00",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.titleSmall!.
            copyWith(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xffD9DBE9)),
          ),
        ),
      ),
      const SizedBox(height: 25,),
      NumericKeyboard(
        onKeyboardTap: (String value) {
            pinController.text = pinController.text + value;
            update();
        },
        rightButtonFn: () {
          HapticFeedback.heavyImpact();
          pinController.text = pinController.text.substring(0, pinController.text.length - 1);
          update();
        },
      ),
    ], title: "Type your preferred amount", height: MediaQuery.of(context).size.height/2);
  }
}