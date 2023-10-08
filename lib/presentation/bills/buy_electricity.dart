import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/general_drop_down.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/presentation/bills/bills_history.dart';
import 'package:behalal/presentation/bills/pay_electricity_bills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BuyElectricityBill extends StatefulWidget {
  const BuyElectricityBill({super.key});

  @override
  State<BuyElectricityBill> createState() => _BuyElectricityBillState();
}

class _BuyElectricityBillState extends State<BuyElectricityBill> {
  String iconPath = "";
  final _controller = Get.put(BillController());
  final searchController = TextEditingController();
  final meterNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailController = TextEditingController();
  final meterTypeController = TextEditingController();
  final amountController = TextEditingController();
  final beneficiaryNameController = TextEditingController();
  bool saveBeneficiary = false;

  void _getElectricityProviders({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      _controller.electricityProviders!.data!.billers!.isEmpty || _controller.electricityProviders!.data!.billers == [] ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/png_images/folder.png", height: 50, width: 50,),
            const Spacing.height(20),
            Text("No electricity", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),)
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
          ...List.generate(_controller.electricityProviders!.data!.billers!.length, (index){
            final data = _controller.electricityProviders!.data!.billers![index];
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
                        Image.asset(PNGImages.electricity, height: 40, width: 40),
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
                    ...List.generate(controller.beneficiary.length, (index){
                      final data = controller.beneficiary[index];
                      return GestureDetector(
                        onTap: (){
                          meterTypeController.text = data["meter_number"]!;
                          provider = data["provider"];
                          setState(() {});
                        },
                        child: AppTransactionTile(
                          leadingWidget: Container(
                            height: 50, width: 50, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.paleBlue),
                            child: Center(child: Image.asset(PNGImages.electricity)),
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
    ], title: "Electricity", height: MediaQuery.of(context).size.height/1.7);
  }

  String? provider;
  @override
  void initState() {
    provider = _controller.electricityProviders?.data?.billers?.first.billername ?? "";
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
              titleWidget: Text("Electricity",
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const Spacing.height(28),
                  Text("Choose a  provider", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),),
                  const Spacing.height(9),
                  GestureDetector(
                    onTap: (){
                      _getElectricityProviders(context: context);
                    },
                    child: Container(
                      height: 55, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xffDBDFE4))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(PNGImages.electricity, height: 40, width: 40,),
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
                      Text("Meter Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
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
                    controller: meterNumber,
                    label: null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const Spacing.height(16),
                  Text("Phone Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                  AppTextField(
                    controller: phoneNumber,
                    label: null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const Spacing.height(16),
                  Text("Email Address", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                  AppTextField(
                    controller: emailController,
                    label: null,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const Spacing.height(16),
                  Text("Meter Type", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                 GeneralDropDown(
                     hint: meterTypeController.text.isEmpty ? "Select Meter Type" : meterTypeController.text,
                   items: controller.meterTypeList.map((item) => DropdownMenuItem<String>(
                     value: item.toString() ?? "",
                     child: Text(item.toString() ?? "", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.black, fontSize: 16.sp,)),
                   )).toList(),
                   onChanged: (value){
                     meterTypeController.text = value.toString();
                   },
                 ),
                  const Spacing.height(16),
                  Text("Amount ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.black, ),),
                  AppTextField(
                    controller: amountController,
                    label: null,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayElectricityBills(selectedProvider: provider!,)));
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
