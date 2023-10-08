import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_bar.dart';
import 'package:behalal/app/widgets/app_text_field.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/presentation/bills/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillController>(
      init: BillController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(titleWidget: Text("Transaction History",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ), dashboard: false, bgColor: AppColors.white, whiteBG: true, centerTitle: false, fontSize: 18.sp,),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children:  [
                  const Spacing.height(12),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
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
                      ),
                      const Spacing.width(12),
                      Container(
                        height: 55, width: 55,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.lightPrimaryColor)),
                        child: Center(
                          child: Image.asset(PNGImages.filter, height: 20, width: 20,),
                        ),
                      )
                    ],
                  ),
                  const Spacing.height(24),
                  Text("Today", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                  ...List.generate(controller.todayTransactions.length, (index){
                    final data = controller.todayTransactions[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            TransactionHistoryDetails(
                            transactionDate: "Dec 31,2022, 02:37",
                                provider: data["provider"] ?? "",
                                phoneNumber: "09045673459",
                                amount: "₦1,500",
                                transactionNumber: "22345666789007",
                                status: data["status"] ?? ""
                            )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), width: double.infinity, decoration: const BoxDecoration(color: AppColors.white),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(PNGImages.transactionHistoryIcon, height: 40, width: 40,),
                                const Spacing.width(10),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data["provider"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                    Text(data["transactionType"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(data["amount"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                Text(data["status"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),



                  const Spacing.height(24),
                  Text("Yesterday", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                  ...List.generate(controller.yesterdayTransactions.length, (index){
                    final data = controller.yesterdayTransactions[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            TransactionHistoryDetails(
                                transactionDate: "Dec 31,2022, 02:37",
                                provider: data["provider"] ?? "",
                                phoneNumber: "09045673459",
                                amount: "₦1,500",
                                transactionNumber: "22345666789007",
                                status: data["status"] ?? ""
                            )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), width: double.infinity, decoration: const BoxDecoration(color: AppColors.white),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(PNGImages.transactionHistoryIcon, height: 40, width: 40,),
                                const Spacing.width(10),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data["provider"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                    Text(data["transactionType"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(data["amount"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                Text(data["status"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),


                  const Spacing.height(24),
                  Text("Yesterday", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                  ...List.generate(controller.olderTransaction.length, (index){
                    final data = controller.olderTransaction[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            TransactionHistoryDetails(
                                transactionDate: "Dec 31,2022, 02:37",
                                provider: data["provider"] ?? "",
                                phoneNumber: "09045673459",
                                amount: "₦1,500",
                                transactionNumber: "22345666789007",
                                status: data["status"] ?? ""
                            )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10), width: double.infinity, decoration: const BoxDecoration(color: AppColors.white),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(PNGImages.transactionHistoryIcon, height: 40, width: 40,),
                                const Spacing.width(10),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data["provider"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                    Text(data["transactionType"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(data["amount"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                                Text(data["status"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
      );
    });
  }
}
