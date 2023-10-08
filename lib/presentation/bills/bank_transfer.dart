import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'bills_history.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({super.key});

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  String provider = "Gt Bank";
  String providerImage = PNGImages.gtBank;
  bool saveBeneficiary = false;
  TextEditingController accountNumber = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final _controller = Get.put(BillController());

  @override
  void initState() {
    // provider = _controller.cableTvProviders?.data?.billers?.first.billername ?? "";
    super.initState();
  }

  void _beneficiary({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      GetBuilder<BillController>(
          init: BillController(),
          builder: (controller){
            return Column(
              children: [
                // Text("Select Beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                // controller.getAllBeneficiariesResponseModel!.data!.beneficiary!.isEmpty || controller.getAllBeneficiariesResponseModel!.data!.beneficiary == [] ?
                // Center(
                //   child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset("assets/png_images/folder.png", height: 50, width: 50,),
                //       const Spacing.height(20),
                //       Text("No beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),)
                //     ],
                //   ),
                // ) :
                Column(
                  children: [
                    ...List.generate(controller.bankBeneficiary.length, (index){
                      final data = controller.bankBeneficiary[index];
                      return GestureDetector(
                        onTap: (){
                          // smartCardNumberController.text = data["meter_number"]!;
                          // provider = data["provider"];
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: AppTransactionTile(
                          leadingWidget: Container(
                            height: 50, width: 50, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.paleBlue),
                            child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w700),)),
                          ),
                          titleWidget: Text(data["name"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455)),),
                          subtitleWidget:  Text(data["account_number"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
                        ),
                      );
                    })
                  ],
                )
              ],
            );
          })
    ], title: "Beneficiaries", height: MediaQuery.of(context).size.height/1.7);
  }



  void _selectABank({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      _controller.bank.isEmpty ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/png_images/folder.png", height: 50, width: 50,),
            const Spacing.height(20),
            Text("No bank", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),)
          ],
        ),
      ) : Column(
        children: [
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
          const Spacing.height(16),
          ...List.generate(_controller.bank.length, (index){
            final data = _controller.bank[index];
            return GestureDetector(
              onTap: (){
                provider = data["bank"]!;
                providerImage = data["bank_icon"]!;
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), width: double.infinity,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(data["bank_icon"]!, height: 40, width: 40),
                        const Spacing.width(10),
                        Expanded(child: Text(data["bank"] ?? "", overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w400),))
                      ],
                    ),
                  ),
                  const Divider()
                ],
              ),
            );
          })
        ],
      )
    ], title: "Select a bank", height: MediaQuery.of(context).size.height/1.5);
  }

  void _payment({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      GetBuilder<BillController>(
          init: BillController(),
          builder: (controller){
            return Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(providerImage, height: 45, width: 45,),
                const Spacing.height(14),
                Text("LUKMAN IBRAHIM OLALEKAN", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),),
                const Spacing.height(8),
                Text("Guaranty Trust Bank(0123456789)", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),),
                const Spacing.height(24),
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
                ),   const Spacing.height(196),
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
    ], title: "", height: MediaQuery.of(context).size.height/1.2);
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleWidget: Text("Bank Transfer ",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
          ),
        ), centerTitle: false,
        dashboard: false,
        bgColor: AppColors.white, whiteBG: true,
        actions: TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const BillHistory()));
      },
          child: Text("History", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 18, color: AppColors.primaryColor), )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  children: [
                    const Spacing.height(12),
                    Align(alignment: Alignment.centerLeft,
                        child: Text("Enter phone number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),)),
                    const Spacing.height(9),
                    GestureDetector(
                      onTap: (){
                        _selectABank(context: context);
                      },
                      child: Container(
                        height: 55, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffDBDFE4))),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(providerImage, height: 35, width: 35,),
                            const Spacing.width(10),
                            Expanded(
                              child: Text(provider, overflow: TextOverflow.ellipsis, maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.grey, size: 18,),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacing.height(24),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enter an account number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                        GestureDetector(
                          onTap: (){
                            _beneficiary(context: context);
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Beneficiaries", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey, ),),
                              const Spacing.width(5),
                              const Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.black, size: 18,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacing.height(10),
                    AppTextField(
                      controller: accountNumber,
                      label: null, hintText: "e.g 01234567",
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const Spacing.height(10),
                    Container(
                      width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                      child: Text("Lukman Ibrahim Olalekan", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryColor, )),
                    ),
                    const Spacing.height(148),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8)), borderRadius: BorderRadius.circular(15)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Save to beneficiary?", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black)),
                          Switch.adaptive(value: saveBeneficiary,
                              onChanged: (value){
                                setState(() {
                                  saveBeneficiary = !saveBeneficiary;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                )
            ),
            const Spacing.height(12),
            HalalPrimaryButton(
              buttonBorder: AppColors.primaryColor, btnColor: AppColors.primaryColor, btnTitle: "Next",
              btnHeight: 45, onTap: (){
              _payment(context: context);
            },
            ),
            const Spacing.height(40),
          ],
        ),
      ),
    );
  }
}
