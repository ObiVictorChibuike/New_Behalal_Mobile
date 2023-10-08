import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/universal_utils/snackbar_util.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/dropdown_textfield_with_icon.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/loader_bottom_sheet.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/presentation/bills/bills_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class BuyAirtime extends StatefulWidget {
  const BuyAirtime({super.key});

  @override
  State<BuyAirtime> createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
  final _controller = Get.put(BillController());

  @override
  void initState() {
    _controller.getAirtimeProvidersById(id: "109");
    provider.text = "MTN";
    super.initState();
  }

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
          _controller.purchaseAirtime(
              amount: amount,
              itemCode: itemCode,
              phoneNumber: phoneNumber,
              transactionPin: _controller.pinCodeController.text,
              saveAsBeneficiary: saveBeneficiary,
              provider: provider.text
          );
      },),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.7);
  }


  void _beneficiary({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
          GetBuilder<BillController>(
            init: BillController(),
              builder: (controller){
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppColors.paleBlue),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 50, width: 50, decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle,
                              border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child: const Center(child: Icon(Iconsax.mobile, color: AppColors.primaryColor,))
                          ),
                          const Spacing.width(10),
                          Text("Select phone number from Contact", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500))
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                    ],
                  ),
                ),
                const Spacing.height(23),
                Text("Select Beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                controller.beneficiary!.isEmpty || controller!.beneficiary == [] ?
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
                    ...List.generate(controller.beneficiary.length, (index){
                      final data = controller.beneficiary[index];
                      return AppTransactionTile(
                        leadingWidget: Container(
                          height: 50, width: 50, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.paleBlue),
                          child: Center(child: Text("AS", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w700),)),
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
                      );
                    })
                  ],
                )
              ],
            );
          })
    ], title: "Airtime", height: MediaQuery.of(context).size.height/1.7);
  }

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Image.asset(item.text == "Glo QuickCharge" ?
        PNGImages.glo : item.text == "Airtel Mobile Top-Up" ?
        PNGImages.airtel : item.text == "Etisalat Recharge Top-Up" ?
        PNGImages.mobile9 : PNGImages.mtn, height: 30, width: 30,),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black, fontSize: 13
            ),
          ),
        ),
      ],
    );
  }
  final beneficiaryNameController = TextEditingController();
  final phoneController = TextEditingController();
  final provider = TextEditingController();
   bool saveBeneficiary = false;
   String? imagePath;
   String? amount;
   String? paymentItemId;
   int? selectedAmountIndex;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final items = _controller.airtimeProviders!.data!.billers!.map((e) => MenuItem(text: e.billername.toString(), )).toList();
    return SafeArea(top: false, bottom: false,
        child: GetBuilder<BillController>(
          init: BillController(),
            builder: (controller){
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              titleWidget: Text("Buy Airtime",
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
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Spacing.height(12),
                    Align(alignment: Alignment.centerLeft,
                        child: Text("Enter phone number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),)),
                    const Spacing.height(9),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropDownTextFieldWithIcon(
                            items: [
                              ...items.map((item) => DropdownMenuItem<MenuItem>(value: item, child: buildItem(item),),),
                              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
                            ],
                            onChanged: (value){
                              final data = value! as MenuItem;
                              if(data.text == "Glo QuickCharge"){
                                setState(() {
                                  imagePath = PNGImages.glo;
                                  provider.text = "GLO";
                                  controller.getAirtimeProvidersById(id: '402');
                                });
                              }else if(data.text == "Airtel Mobile Top-Up"){
                                setState(() {
                                  imagePath = PNGImages.airtel;
                                  provider.text = "AIRTEL";
                                  controller.getAirtimeProvidersById(id: '901');
                                });
                              }else if(data.text == "Etisalat Recharge Top-Up"){
                                setState(() {
                                  imagePath = PNGImages.mobile9;
                                  provider.text = "9 MOBILE";
                                  controller.getAirtimeProvidersById(id: '120');
                                });
                              }else if(data.text == "MTN e-Charge Prepaid"){
                                setState(() {
                                  imagePath = PNGImages.mtn;
                                  provider.text = "MTN";
                                  controller.getAirtimeProvidersById(id: '109');
                                });
                              }
                            },
                            customHeights: [
                              ...List<double>.filled(items.length, 48),
                              8,
                            ],
                            imagePath: imagePath,
                          ),
                        ),
                        Expanded(
                            child: AppTextField(
                              label: null, controller: phoneController,
                              hintText: 'Enter Password',
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  _beneficiary(context: context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  height: 20, width: 20, decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                                  child: Center(child: Image.asset(PNGImages.user, height: 20, width: 20,)),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    const Spacing.height(40),
                    controller.airTimeProviderById == AppString.loading ?
                        Container(
                          height: MediaQuery.of(context).size.height/2.8,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.lightPrimaryColor)),
                          child: const CupertinoActivityIndicator(),
                        ) : controller.airTimeProviderById == AppString.completed ?
                    Container(
                      padding: const EdgeInsets.all(16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightPrimaryColor)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Enter Amount", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                          const Spacing.height(10),
                          TextFormField(
                            controller: controller.amountController,
                            onChanged: (value){
                              amount = value;
                            },
                            decoration: InputDecoration(
                                suffixIcon:  GestureDetector(
                                  onTap: (){
                                    if(phoneController.text.isEmpty){
                                      SnackbarUtil.showErrorSnackbar("Please enter phone number");
                                    }else if(provider.text.isEmpty){
                                      SnackbarUtil.showErrorSnackbar("Please select provider");
                                    }else if(controller.amountController.text.isEmpty){
                                      SnackbarUtil.showErrorSnackbar("Please select or enter amount");
                                    }else{
                                      if(_formKey.currentState!.validate()){
                                        _paymentSheet(
                                            context: context,
                                            phoneNumber: phoneController.text,
                                            provider: provider.text,
                                            amount: controller.amountController.text,
                                            paymentItemId: paymentItemId!
                                        );
                                      }
                                    }
                                  },
                                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), width: 80, margin: const EdgeInsets.only(bottom: 5, top: 15),
                                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(40)),
                                    child: Center(
                                      child: Text("Buy", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.white),),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          const Divider(),
                          controller.providerId == "109" ?
                          Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing: MediaQuery.of(context).size.width/35,
                            children: [
                              ...List.generate(controller.mtn!.data!.billerItems!.length, (index){
                                final item = controller.mtn!.data!.billerItems![index];
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedAmountIndex = index;
                                      amount = item.amount.toString();
                                      controller.amountController.text = "₦ ${item.amount.toString()}";
                                      paymentItemId = item.paydirectItemCode;
                                    });
                                  },
                                  child: Container(
                                    height: 60, width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: selectedAmountIndex == index ? AppColors.primaryColor : const Color.fromRGBO(219, 223, 228, 0.8))),
                                    child: Center(child: Text("₦ ${item.amount ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12,
                                          fontWeight: FontWeight.w400, color: AppColors.black),)),
                                  ),
                                );
                              })
                            ],
                          ) : controller.providerId == "901" ?
                          Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing: MediaQuery.of(context).size.width/35,
                            children: [
                              ...List.generate(controller.airtel!.data!.billerItems!.length, (index){
                                final item = controller.airtel!.data!.billerItems![index];
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedAmountIndex = index;
                                      controller.amountController.text = "₦ ${item.amount.toString()}";
                                      paymentItemId = item.paydirectItemCode;
                                    });
                                  },
                                  child: Container(
                                    height: 60, width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: selectedAmountIndex == index ? AppColors.primaryColor : const Color.fromRGBO(219, 223, 228, 0.8))),
                                    child: Center(child: Text("₦ ${item.amount ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12,
                                          fontWeight: FontWeight.w400, color: AppColors.black),)),
                                  ),
                                );
                              })
                            ],
                          ) : controller.providerId == "402" ?
                          Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing: MediaQuery.of(context).size.width/35,
                            children: [
                              ...List.generate(controller.glo!.data!.billerItems!.length, (index){
                                final item = controller.glo!.data!.billerItems![index];
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedAmountIndex = index;
                                      controller.amountController.text = "₦ ${item.amount.toString()}";
                                      paymentItemId = item.paydirectItemCode;
                                    });
                                  },
                                  child: Container(
                                    height: 60, width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: selectedAmountIndex == index ? AppColors.primaryColor : const Color.fromRGBO(219, 223, 228, 0.8))),
                                    child: Center(child: Text("₦ ${item.amount ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12,
                                          fontWeight: FontWeight.w400, color: AppColors.black),)),
                                  ),
                                );
                              })
                            ],
                          ) : controller.providerId == "120" ?
                          Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing: MediaQuery.of(context).size.width/35,
                            children: [
                              ...List.generate(controller.mobile9!.data!.billerItems!.length, (index){
                                final item = controller.mobile9!.data!.billerItems![index];
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedAmountIndex = index;
                                      controller.amountController.text = "₦ ${item.amount.toString()}";
                                      paymentItemId = item.paydirectItemCode;
                                    });
                                  },
                                  child: Container(
                                    height: 60, width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: selectedAmountIndex == index ? AppColors.primaryColor : const Color.fromRGBO(219, 223, 228, 0.8))),
                                    child: Center(child: Text("₦ ${item.amount ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12,
                                          fontWeight: FontWeight.w400, color: AppColors.black),)),
                                  ),
                                );
                              })
                            ],
                          ) : const SizedBox(),
                          const Spacing.height(25),
                          RichText(text: TextSpan(text: "You will earn cashback of ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),
                              children: [TextSpan(text: "1%", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryColor)),
                              ]
                          )),
                        ],
                      ),
                    ) : controller.airTimeProviderById == AppString.error ?
                    Container(
                      height: MediaQuery.of(context).size.height/2.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.lightPrimaryColor)),
                      child: const CupertinoActivityIndicator(),
                    ) : const SizedBox(),
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
                    const Spacing.height(20),
                    saveBeneficiary == false ? const SizedBox() : Text("Beneficiary", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                    saveBeneficiary == false ? const SizedBox() : const Spacing.height(9),
                    saveBeneficiary == false ? const SizedBox() :
                    AppTextField(
                      controller: beneficiaryNameController,
                      hintText: 'Enter Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter beneficiary name";
                        }
                        return null;
                      },
                      borderColor: const Color.fromRGBO(219, 223, 228, 0.8),
                    ),
                    const Spacing.height(40),
                  ],
                ),
              ),
            ),
          );
        })
    );
  }
}
