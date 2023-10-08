import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/dropdown_textfield_with_icon.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/loader_bottom_sheet.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/presentation/bills/bills_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class BuyData extends StatefulWidget {
  const BuyData({super.key});

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> with TickerProviderStateMixin{
  final _controller = Get.put(BillController());
  final provider = TextEditingController();

  @override
  void initState() {
    _controller.getDataProvidersById(id: "109");
    provider.text = "MTN";
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  _loaderDialog({required BuildContext context}){
    ShowLoaderBottomSheet().showDismissibleBottomSheet(
        context: context,
        title: "Processing Transaction",
        height: MediaQuery.of(context).size.height/2
    );
  }

  void _paymentSheet({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Mobile Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("090 3554 3467", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Provider", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("MTN", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
        ],
      ),
      const Spacing.height(24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Amount", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("₦ 500.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black)),
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
          _paymentPinDialog(context: context);
        },
      ),
    ], title: "Payment", height: MediaQuery.of(context).size.height/1.5);
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
        btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Verify", onTap: (){
        Navigator.of(context).pop();
        _loaderDialog(context: context);
      },
      ),
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
                    ...List.generate(controller.getAllBeneficiariesResponseModel!.data!.beneficiary!.length, (index){
                      final data = controller.getAllBeneficiariesResponseModel!.data!.beneficiary![index];
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
                                  child: Center(child: Text(data.provider ?? "",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455))),
                                  )
                              ),
                              const Spacing.width(10),
                              const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 18,)
                            ],
                          ),
                        ),
                        titleWidget: Text(data.name ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xff394455)),),
                        subtitleWidget:  Text(data.phoneNumber ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
                      );
                    })
                  ],
                )
              ],
            );
          })
    ], title: "Airtime", height: MediaQuery.of(context).size.height/1.7);
  }

  var tabs = [
    const Tab(text: "Daily"),
    const Tab(text: "Weekly"),
    const Tab(text: "2weeks"),
    const Tab(text: "Monthly"),
    const Tab(text: "3-months"),
  ];
  TabController? tabController;
  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
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
            titleWidget: Text("Buy Data bundle",
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
            child: Column(
              children: [
                const Spacing.height(12),
                Align(alignment: Alignment.centerLeft,
                    child: Text("Enter phone number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),)),
                const Spacing.height(9),
                Row(
                  children: [
                    const DropDownTextFieldWithIcon(),
                    Expanded(
                        child: AppTextField(
                          label: null,
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
                const Spacing.height(24),
                Row(
                  children: [
                    Text("Choose a bundle", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black)),
                    const Spacing.width(5),
                    RichText(text:
                    TextSpan(text: "You will earn cashback of ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),
                        children: [
                          TextSpan(text: "1%", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryColor)),
                        ])),
                  ],
                ),
                const Spacing.height(16),
                DefaultTabController(
                  length: 5,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: AppColors.black,
                    controller: tabController,
                    tabs: tabs,
                  ),
                ),
                const Spacing.height(16),
                Expanded(
                  flex: 6,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing:  MediaQuery.of(context).size.width/35,
                        children: [
                          ...List.generate(controller.dataPlan.length, (index){
                            return Container(
                              height: 60, width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child:   Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(controller.dataPlan[index]["bundle"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["duration"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["amount"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                ],
                              )),
                            );
                          })
                        ],
                      ),
                      Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing:  MediaQuery.of(context).size.width/35,
                        children: [
                          ...List.generate(controller.dataPlan.length, (index){
                            return Container(
                              height: 60, width: 100,
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child:   Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(controller.dataPlan[index]["bundle"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["duration"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["amount"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                ],
                              )),
                            );
                          })
                        ],
                      ),
                      Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing:  MediaQuery.of(context).size.width/35,
                        children: [
                          ...List.generate(controller.dataPlan.length, (index){
                            return Container(
                              height: 60, width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child:   Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(controller.dataPlan[index]["bundle"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["duration"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["amount"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                ],
                              )),
                            );
                          })
                        ],
                      ),
                      Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing:  MediaQuery.of(context).size.width/35,
                        children: [
                          ...List.generate(controller.dataPlan.length, (index){
                            return Container(
                              height: 60, width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child:   Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(controller.dataPlan[index]["bundle"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["duration"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["amount"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                ],
                              )),
                            );
                          })
                        ],
                      ),
                      Wrap(spacing: MediaQuery.of(context).size.width/35, runSpacing:  MediaQuery.of(context).size.width/35,
                        children: [
                          ...List.generate(controller.dataPlan.length, (index){
                            return Container(
                              height: 60, width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8))),
                              child:   Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(controller.dataPlan[index]["bundle"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["duration"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  Text(controller.dataPlan[index]["amount"]!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black),),
                                ],
                              )),
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8)), borderRadius: BorderRadius.circular(15)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Save to beneficiary?", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black)),
                      Switch.adaptive(value: false,
                          onChanged: (value){

                          })
                    ],
                  ),
                ),
                const Spacing.height(9),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(219, 223, 228, 0.8)), borderRadius: BorderRadius.circular(15)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Ibrahim Lukman", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black)),
                    ],
                  ),
                ),
                Spacing.height(MediaQuery.of(context).size.height/4),
              ],
            ),
          ),
        ),
      );
    });
  }
}
