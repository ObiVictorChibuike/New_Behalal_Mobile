import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class P2PTransfer extends StatefulWidget {
  const P2PTransfer({super.key});

  @override
  State<P2PTransfer> createState() => _P2PTransferState();
}

class _P2PTransferState extends State<P2PTransfer> {
  TextEditingController searchController = TextEditingController();
  bool saveBeneficiary = false;
  TextEditingController accountNumber = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final _controller = Get.put(BillController());


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
        controller: _controller.pinCodeController,
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
        },),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.7);
  }

  void _paymentSheet({required BuildContext context, required String bank, required String accountNumber, required String amount, required String fees}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bank", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(bank, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Account Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(accountNumber.toUpperCase(), style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Amount", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(amount, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Fees", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("₦24,500", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bonus to Earn", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("₦Cashback", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
        ],
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
      const Spacing.height(49),
      HalalPrimaryButton(
        btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Pay",
        onTap: (){
          Navigator.of(context).pop();
          _paymentPinDialog(context: context);
          // _paymentPinDialog(context: context, amount: amount, itemCode: paymentItemId, phoneNumber: phoneNumber);
        },
      ),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.5);
  }

  void _payment({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      GetBuilder<BillController>(
          init: BillController(),
          builder: (controller){
            return Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacing.height(20),
                Container(
                  padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50, width: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.paleYellow.withOpacity(0.2)),
                            child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.paleYellow, fontSize: 14, fontWeight: FontWeight.w700),)),
                          ),
                          const Spacing.width(10),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Lukman Ibrahim Olalekan", style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455))),
                              const Spacing.width(10),
                              Text("0812 345 6789", style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff808A9A))),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                    ],
                  ),
                ),
                const Spacing.height(36),
                AppTextField(
                  label: "Enter amount", controller: amountController,
                  keyboardType: TextInputType.text, prefixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(PNGImages.naira, height: 10, width: 10,),
                ),
                  textInputAction: TextInputAction.next,
                ),
                const Spacing.height(10),
                Row(
                  children: [
                    Text("Account Balance:", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                    const Spacing.width(5),
                    Text("₦500,000", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                  ],
                ),
                const Spacing.height(28),
                AppTextField(
                  controller: accountNumber,
                  label: "Remarks",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),   const Spacing.height(70),
                HalalPrimaryButton(
                  buttonBorder: AppColors.primaryColor, btnColor: AppColors.primaryColor, btnTitle: "Confirm",
                  btnHeight: 45, onTap: (){
                  Navigator.of(context).pop();
                  _paymentSheet(context: context, bank: "Guaranty Trust Bank", accountNumber: "012345678", amount: "₦24,500", fees: "");
                },
                ),
              ],
            );
          })
    ], title: "Next", height: MediaQuery.of(context).size.height/1.5);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleWidget: Text("Send to someone",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
          ),
        ), centerTitle: false,
        dashboard: false,
        bgColor: AppColors.white, whiteBG: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text("Enter phone number or Halal tag",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.black100),),
          const Spacing.height(5),
          AppTextField(
            controller: searchController,
            label: null,
            hintText: 'Search', prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(PNGImages.search, height: 15, width: 15,),
          ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value){

            },
          ),
          const Spacing.height(10),
          Container(
            padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.paleBlue, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50, width: 50, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.paleBlue),
                      child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w700),)),
                    ),
                    const Spacing.width(10),
                    Text("Lukman Ibrahim Olalekan", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
              ],
            ),
          ),
          const Spacing.height(27),
          Text("Recent",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.black100),),
          const Spacing.height(16),
          ...List.generate(3, (index) =>
              GestureDetector(
                onTap: (){
                  _payment(context: context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50, width: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.paleYellow.withOpacity(0.2)),
                            child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.paleYellow, fontSize: 14, fontWeight: FontWeight.w700),)),
                          ),
                          const Spacing.width(10),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Lukman Ibrahim Olalekan", style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455))),
                              const Spacing.width(10),
                              Text("0812 345 6789", style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff808A9A))),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                    ],
                  ),
                ),
              ),
          ),
          const Spacing.height(31),
          Text("People on Halal",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.black100),),
          const Spacing.height(16),
          ...List.generate(6, (index) =>
              Container(
                padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50, width: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.paleYellow.withOpacity(0.2)),
                          child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.paleYellow, fontSize: 14, fontWeight: FontWeight.w700),)),
                        ),
                        const Spacing.width(10),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lukman Ibrahim Olalekan", style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455))),
                            const Spacing.width(10),
                            Text("@IB35", style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff808A9A))),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
