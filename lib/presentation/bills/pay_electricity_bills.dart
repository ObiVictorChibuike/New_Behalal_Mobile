import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/universal_utils/dialog_util.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/key_value_holder_widget.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PayElectricityBills extends StatefulWidget {
  final String selectedProvider;
  const PayElectricityBills({super.key, required this.selectedProvider});

  @override
  State<PayElectricityBills> createState() => _PayElectricityBillsState();
}

class _PayElectricityBillsState extends State<PayElectricityBills> {
  final _controller = Get.put(BillController());
  final pinCodeController = TextEditingController();
  void _paymentPinDialog({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Text("Approve payment", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.black)),
      const Spacing.height(31),
      Text("Please enter your passcode to verify it’s you.", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w400)),
      const Spacing.height(32),
      Text("Enter your 4 digit passcode", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
      const Spacing.height(18),
      PinCodeTextField(
        controller: pinCodeController,
        hideCharacter: true,
        highlight: true,
        highlightColor: Colors.blue,
        pinBoxRadius: 8,
        defaultBorderColor: const Color(0xffEBEBEB),
        hasTextBorderColor: AppColors.primaryColor,
        highlightPinBoxColor: AppColors.white,
        maxLength: 4,
        pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        // hasError: hasError,
        // maskCharacter: "😎",
        onDone: (text) => _controller.onOTPCodeChanged(text),
        pinBoxWidth: 48,
        pinBoxHeight: 48,
        wrapAlignment: WrapAlignment.spaceAround,
        pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
        pinTextStyle: TextStyle(fontSize: 22.0.sp),
        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
        pinBoxColor: Colors.white,
        pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
        highlightAnimation: true,
        keyboardType: TextInputType.number,
      ),
      const Spacing.height(43),
      RichText(text:
      TextSpan(text: "Can't remember? ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          children: [
            TextSpan(text: "Contact support for help.", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryColor)),
          ])),
      const Spacing.height(80),
      HalalPrimaryButton(
        btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Verify",
        onTap: (){
          Navigator.of(context).pop();
          loaderDialog(context: Get.context!);
        },),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.7);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top:  false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            titleWidget: Text("Electricity",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ), centerTitle: false,
            dashboard: false,
            bgColor: AppColors.white, whiteBG: true, actions: TextButton(onPressed: (){},
              child: Text("History", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 18, color: AppColors.primaryColor), )),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                Container(
                  height: 55, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffDBDFE4))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(PNGImages.electricity, height: 40, width: 40,),
                      const Spacing.width(10),
                      Expanded(
                        child: Text(widget.selectedProvider, overflow: TextOverflow.ellipsis, maxLines: 2,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),),
                      ),
                    ],
                  ),
                ),
                const Spacing.height(24),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(10), color: AppColors.white),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,
                          child: Text("Ikeja Electricity Payment", overflow: TextOverflow.ellipsis, 
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),
                          )
                      ),
                      const KeyAndValueHolder(keys: "Company", value: "capricorn_ikeja"),
                      const KeyAndValueHolder(keys: "Address", value: "7, Abiola road, Ogba, Lagos"),
                      const KeyAndValueHolder(keys: "Meter Number", value: "21340000789"),
                      const KeyAndValueHolder(keys: "Meter Type", value: "Prepaid"),
                      const KeyAndValueHolder(keys: "Name", value: "Adebola Ismail"),
                      const KeyAndValueHolder(keys: "Amount", value: "₦5000"),
                      const KeyAndValueHolder(keys: "Phone Number", value: "09067893456"),
                      const KeyAndValueHolder(keys: "Email Address", value: "abcd@gmail.com"),
                      const KeyAndValueHolder(keys: "Bonus to Earn", value: "+₦5 Cashback", valueColor: AppColors.primaryColor,),
                    ],
                  ),
                ),
                const Spacing.height(24),
                Container(width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(PNGImages.halalIcon, height: 20, width: 20,),
                          const Spacing.width(10),
                          Text("Balance", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text("₦120,325", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
                    ],
                  ),
                ),
                const Spacing.height(24),
                Container(width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(PNGImages.balance, height: 20, width: 20,),
                          const Spacing.width(10),
                          Text("Cashback Balance", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text("₦50", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
                    ],
                  ),
                ),
                const Spacing.height(57),
                HalalPrimaryButton(
                  buttonBorder: AppColors.primaryColor, btnColor: AppColors.primaryColor, btnTitle: "Pay",
                  btnHeight: 45, onTap: (){
                  _paymentPinDialog(context: context);
                },
                ),
                const Spacing.height(48),
              ],
            ),
          ),
        )
    );
  }
}
