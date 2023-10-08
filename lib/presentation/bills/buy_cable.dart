import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/widgets/app_bar.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/app_text_field.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'bills_history.dart';

class BuyCable extends StatefulWidget {
  const BuyCable({super.key});

  @override
  State<BuyCable> createState() => _BuyCableState();
}

class _BuyCableState extends State<BuyCable> {
  final _controller = Get.put(BillController());
  final smartCardNumberController = TextEditingController();
  final subscriptionPeriod = TextEditingController();
  final packageController = TextEditingController();
  final searchController = TextEditingController();
  bool saveBeneficiary = false;


  void _paymentSheet({required BuildContext context, required String phoneNumber, required String provider, required String amount, required String paymentItemId}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Mobile Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(phoneNumber, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Provider", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(provider.toUpperCase(), style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
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
          Text("Bonus to Earn", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("+₦5 Cashback", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
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
          _paymentPinDialog(context: context, amount: amount, itemCode: paymentItemId, phoneNumber: phoneNumber);
        },
      ),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.5);
  }

  void _paymentPinDialog({required BuildContext context, required String amount, required String itemCode, required String phoneNumber}){
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
          // _controller.purchaseAirtime(
          //     amount: amount,
          //     itemCode: itemCode,
          //     phoneNumber: phoneNumber,
          //     transactionPin: _controller.pinCodeController.text,
          //     saveAsBeneficiary: saveBeneficiary,
          //     provider: provider!
          // );
        },),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.7);
  }


  void _getCableProvider({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      _controller.cableTvProviders!.data!.billers!.isEmpty || _controller.cableTvProviders!.data!.billers == [] ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/png_images/folder.png", height: 50, width: 50,),
            const Spacing.height(20),
            Text("No cable providers", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),)
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
          ...List.generate(_controller.cableTvProviders!.data!.billers!.length, (index){
            final data = _controller.cableTvProviders!.data!.billers![index];
            return GestureDetector(
              onTap: (){
                setState(() {
                  provider = data.billername;
                });
                Navigator.of(context).pop();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), width: double.infinity,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(PNGImages.dstv, height: 40, width: 40),
                        const Spacing.width(10),
                        Expanded(child: Text(data.billername ?? "", overflow: TextOverflow.ellipsis,
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
    ], title: "Choose a provider", height: MediaQuery.of(context).size.height/1.5);
  }

  void _package({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      GetBuilder<BillController>(
          init: BillController(),
          builder: (controller){
            return Column(
              children: [
                ...List.generate(_controller.packageAmount.length, (index){
                  return GestureDetector(
                    onTap: (){
                      package = _controller.packageAmount[index]["package"];
                      packageAmount = _controller.packageAmount[index]["amount"];
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      width: double.infinity, decoration: const BoxDecoration(color: AppColors.white, ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_controller.packageAmount[index]["package"] ?? "", overflow: TextOverflow.ellipsis, maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),),
                          Text(_controller.packageAmount[index]["amount"] ?? "", overflow: TextOverflow.ellipsis, maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),)
                        ],
                      ),
                    ),
                  );
                })
              ],
            );
          })
    ], title: "Select Package", height: MediaQuery.of(context).size.height/2);
  }

  void _beneficiary({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      GetBuilder<BillController>(
          init: BillController(),
          builder: (controller){
            return Column(
              children: [
                const Spacing.height(23),
                Text("Select Beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                controller.getAllBeneficiariesResponseModel!.data!.beneficiary!.isEmpty || controller.getAllBeneficiariesResponseModel!.data!.beneficiary == [] ?
                Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/png_images/folder.png", height: 50, width: 50,),
                      const Spacing.height(20),
                      Text("No beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),)
                    ],
                  ),
                ) :
                Column(
                  children: [
                    ...List.generate(controller.cableTv.length, (index){
                      final data = controller.beneficiary[index];
                      return GestureDetector(
                        onTap: (){
                          smartCardNumberController.text = data["meter_number"]!;
                          provider = data["provider"];
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: AppTransactionTile(
                          leadingWidget: Container(
                            height: 50, width: 50, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.paleBlue),
                            child: Center(child: Image.asset(PNGImages.dstv)),
                          ),
                          tagWidget: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(color: const Color.fromRGBO(219, 223, 228, 0.8), borderRadius: BorderRadius.circular(20)),
                                    child: Center(child: Text(data["provider"] ?? "",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455))),
                                    )
                                ),
                                const Spacing.width(10),
                                const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                              ],
                            ),
                          ),
                          titleWidget: Text(data["name"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455)),),
                          subtitleWidget:  Text(data["meter_number"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
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
  String? provider;
  String? package;
  String? packageAmount;
  @override
  void initState() {
    provider = _controller.cableTvProviders?.data?.billers?.first.billername ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillController>(
      init: BillController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              titleWidget: Text("Cable ",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ), centerTitle: false,
              dashboard: false,
              bgColor: AppColors.white, whiteBG: true, actions: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BillHistory()));
            },
                child: Text("History", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 18, color: AppColors.primaryColor), )),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Spacing.height(12),
                  Align(alignment: Alignment.centerLeft,
                      child: Text("Choose a  provider", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),)),
                  const Spacing.height(9),
                  GestureDetector(
                    onTap: (){
                      _getCableProvider(context: context);
                    },
                    child: Container(
                      height: 55, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffDBDFE4))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(PNGImages.dstv, height: 40, width: 40,),
                          const Spacing.width(10),
                          Expanded(
                            child: Text(provider!, overflow: TextOverflow.ellipsis, maxLines: 2,
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
                      Text("Smartcard Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
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
                  AppTextField(
                    controller: smartCardNumberController,
                    label: null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const Spacing.height(16),
                  Text("Subscription Period", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                  const Spacing.height(9),
                  AppTextField(
                    controller: subscriptionPeriod,
                    label: null, enabled: true,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const Spacing.height(16),
                  Text("Package", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                  const Spacing.height(9),
                  GestureDetector(
                    onTap: (){
                      _package(context: context);
                    },
                    child: Container(
                      height: 55, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffDBDFE4))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(package ?? "", overflow: TextOverflow.ellipsis, maxLines: 2,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),),
                          ),
                          Row(
                            children: [
                            Text(packageAmount ?? "", overflow: TextOverflow.ellipsis, maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, ),),
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.grey, size: 18,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacing.height(20),
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
                  const Spacing.height(52),
                  HalalPrimaryButton(
                    btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Proceed",
                    onTap: (){
                      if(provider!.isEmpty || smartCardNumberController.text.isEmpty || package!.isEmpty || packageAmount!.isEmpty){
                        SnackbarUtil.showErrorSnackbar("Kindly fill required fields");
                      }else{
                        _paymentSheet(context: context, phoneNumber: smartCardNumberController.text, provider: provider!, amount: packageAmount!, paymentItemId: "103");
                      }
                    },),
                  const Spacing.height(40),
                ],
              ),
            ),
          )
      );
    });
  }
}
