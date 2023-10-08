import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/router.dart';
import 'package:behalal/app/universal_utils/currency_util.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/controller/transfer_controllers/transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WithdrawalConfirmation extends StatelessWidget {
  const WithdrawalConfirmation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: 'Confirm Withdrawal',
        dashboard: false,
        whiteBG: true,
        bgColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(
          builder: (_controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xffE1F5FF),
                      child: SvgPicture.asset(
                        SVGImages.user2,
                        height: 50,
                      ),
                    ),
                    const Spacing.height(15),
                    Text(
                      '${_controller.listBankAccounts[_controller.listBankAccounts.length - 1]['account_name']}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.height(5),
                    Text(
                      '${_controller.listBankAccounts[_controller.listBankAccounts.length - 1]['account_number']}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.height(5),
                    Text(
                      '${_controller.listBankAccounts[_controller.listBankAccounts.length - 1]['bank_name']}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.height(5),
                    Text(
                      'WithHalal - Bank Withdrawal',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Spacing.height(35),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacing.height(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Withdraw amount:',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '# ${CurrencyUtil.formatCurrency(double.parse(CurrencyUtil.getAmount(_controller.withdrawAmount.toString())))}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacing.height(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction fee:',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "# ${_controller.fee?.toString()}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacing.height(35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '# ${CurrencyUtil.formatCurrency(double.parse(_controller.totalAmount.toString()))}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.primaryColor,
                    ),
                    // const Spacing.height(55),
                    // Text(
                    //   'Input authentication code to\n confirm your transaction.',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 13.sp,
                    //     color: AppColors.primaryColor,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // const Spacer(),
                    // PinCodeTextField(
                    //   controller: _controller.pinCodeController,
                    //   hideCharacter: true,
                    //   highlight: true,
                    //   highlightColor: Colors.blue,
                    //   pinBoxRadius: 8,
                    //   defaultBorderColor: AppColors.primaryColor,
                    //   hasTextBorderColor: AppColors.primaryColor,
                    //   highlightPinBoxColor: AppColors.white,
                    //   maxLength: 4,
                    //   pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                    //   // onDone: (text) => _controller.onPINChanged(int.parse(text)),
                    //   pinBoxWidth: 52,
                    //   pinBoxHeight: 52,
                    //   wrapAlignment: WrapAlignment.spaceAround,
                    //   pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    //   pinTextStyle: TextStyle(fontSize: 22.0.sp),
                    //   pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                    //   pinBoxColor: Colors.white,
                    //   pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                    //   highlightAnimation: true,
                    //   keyboardType: TextInputType.number,
                    // ),
                    // const Spacing.height(30),
                    const Spacer(),
                    Text(
                      'Payment will be reflect in seconds',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacing.height(15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                        label: 'Confirm Withdrawal',
                        onPressed: () async {
                          _controller.withdrawMoney();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WithdrawalSuccess extends StatelessWidget {
  const WithdrawalSuccess({
    Key? key,
    required this.message,
    required this.title,
  }) : super(key: key);

  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<String> _tags = ['Gift, Tips & Donation', 'Food & Dining', 'Data & Airtime', 'Auto & Transport', 'Health & Medical', 'Shopping', 'Transfer'];
    // List<String> _iconPath = [SVGImages.buy, SVGImages.link, SVGImages.check, SVGImages.eye];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: GetBuilder<TransferController>(
          builder: (_controller) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(SVGImages.success),
                      const Spacing.height(20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                      ),
                      const Spacing.height(20),
                      Text(
                        message,
                        // "You've successfully withdrawn #${CurrencyUtil.formatCurrency(double.parse(amount.toString()))}\n to $destination via WithHalal - Bank Withdrawal.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   // flex: 2,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // Spacing.height(20),
                //       Text(
                //         'Select Tag:',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontSize: 13.sp, color: AppColors.primaryColor),
                //       ),
                //       const Spacing.height(10),
                //       Wrap(
                //         spacing: 10,
                //         alignment: WrapAlignment.center,
                //         children: [
                //           for (var i in _tags)
                //             // for (var j in _iconPath)
                //             InputChip(
                //               backgroundColor: AppColors.lightPrimaryColor,
                //               avatar: SvgPicture.asset(SVGImages.buy),
                //               label: Text(
                //                 i,
                //                 style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
                //               ),
                //             ),
                //         ],
                //       ),
                //       const Spacer(),
                //       // OutlinedButton(
                //       //   onPressed: () {},
                //       //   style: OutlinedButton.styleFrom(
                //       //     side: const BorderSide(width: 1, color: AppColors.primaryColor),
                //       //   ),
                //       //   child: ListTile(
                //       //     title: Text(
                //       //       'Get receipt',
                //       //       style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
                //       //     ),
                //       //     leading: CircleAvatar(
                //       //       backgroundColor: AppColors.primaryColor,
                //       //       child: SvgPicture.asset(
                //       //         SVGImages.invoice,
                //       //         height: 18,
                //       //         color: AppColors.white,
                //       //       ),
                //       //     ),
                //       //     trailing: const Icon(
                //       //       Icons.share_outlined,
                //       //       color: AppColors.grey,
                //       //     ),
                //       //   ),
                //       // ),
                //       const Spacing.height(20),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width,
                //         child: AppButton(label: 'Return to Dashboard', onPressed: () => Get.offAllNamed(Routes.homeView)),
                //       ),
                //       const Spacing.height(10),
                //     ],
                //   ),
                // )
                const Spacing.height(20),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(label: 'Return to Dashboard', onPressed: () => Get.offAllNamed(Routes.homeView)),
                ),
                const Spacing.height(10),
              ],
            );
          },
        ),
      ),
    );
  }
}
