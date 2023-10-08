import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/transfer_controllers/transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BankTransferView extends StatelessWidget {
  BankTransferView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Bank Transfer',
        dashboard: false,
        whiteBG: true,
        bgColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: GetBuilder<TransferController>(
            builder: (_controller) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Column(
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  letterSpacing: 1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                            const Spacing.height(5),
                            Text(
                              '# ${_controller.walletBalance!}',
                              style: TextStyle(
                                  color: AppColors.primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                        backgroundColor: MaterialStateProperty.all(AppColors.lightPrimaryColor),
                      ),
                    ),
                    const Spacing.height(25),
                    AppDropdown(
                      items: _controller.bankNames,
                      onChanged: _controller.onBankNameChanged,
                      fillColor: AppColors.lightPrimaryColor,
                      label: 'Bank Name',
                      value: _controller.bankName,
                    ),
                    const Spacing.height(25),
                    AppTextField(
                      label: 'Account Number',
                      hintText: 'Enter recipient account number',
                      fillColor: AppColors.lightPrimaryColor,
                      onChanged: _controller.onAccountNumberChanged,
                      validator: _controller.validateAccountNumber,
                      keyboardType: TextInputType.phone,
                    ),
                    Visibility(
                      visible: _controller.nameController.text.isNotEmpty,
                      child: Column(
                        children: [
                          const Spacing.height(25),
                          AppTextField(
                            controller: _controller.nameController,
                            label: 'Account Name',
                            hintText: '',
                            fillColor: AppColors.lightPrimaryColor,
                            enabled: false,
                            // onChanged: _controller.onAmountChanged,
                            // validator: _controller.validateNotEmpty,
                          ),
                        ],
                      ),
                    ),
                    const Spacing.height(25),
                    AppTextField(
                      label: 'Amount',
                      hintText: 'Enter transfer amount',
                      fillColor: AppColors.lightPrimaryColor,
                      onChanged: _controller.onAmountChanged,
                      validator: _controller.validateFundingAmount,
                      keyboardType: TextInputType.number,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Amount',
                    //     style: TextStyle(
                    //       color: AppColors.black,
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 12.sp,
                    //     ),
                    //   ),
                    // ),
                    // TextFormField(
                    //   style: TextStyle(
                    //     color: AppColors.primaryColor,
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 40.sp,
                    //   ),
                    //   inputFormatters: [CurrencyInputFormatter()],
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     hintStyle: TextStyle(
                    //       color: const Color(0xffB8B8B8),
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 12.sp,
                    //     ),
                    //     border: InputBorder.none,
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     errorBorder: UnderlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.red, width: 1.0),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     focusedErrorBorder: UnderlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     disabledBorder: UnderlineInputBorder(
                    //       borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //   ),
                    //   onChanged: _controller.onAmountChanged,
                    //   validator: _controller.validateFundingAmount,
                    // ),

                    const Spacing.height(25),
                    AppTextField(
                      label: 'Note',
                      hintText: 'Transaction description',
                      fillColor: AppColors.lightPrimaryColor,
                      onChanged: _controller.onReasonChanged,
                      validator: _controller.validateNotEmpty,
                    ),
                    const Spacing.height(35),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                        label: 'Next',
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState!.validate()) return;
                          _controller.pinCodeController.clear();
                          _controller.initiateBankTransfer();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
