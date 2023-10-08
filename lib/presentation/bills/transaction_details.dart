import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/app_bar.dart';

import 'package:behalal/app/widgets/key_value_holder_widget.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionHistoryDetails extends StatelessWidget {
  final String transactionDate;
  final String provider;
  final String phoneNumber;
  final String amount;
  final String transactionNumber;
  final String status;
  const TransactionHistoryDetails({super.key, required this.transactionDate, required this.provider, required this.phoneNumber, required this.amount, required this.transactionNumber, required this.status});

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomSheet: Container(
            color: AppColors.white, width: double.infinity, height: MediaQuery.of(context).size.height/8,
            child:  Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0),
              child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(color: AppColors.black, borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text("Share Receipt", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w400),),
                        const Spacing.width(5),
                        const Icon(Icons.share, color: AppColors.white,)
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3, height: 40,
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(50)),
                    // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(child: Text("Download", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w400),),),
                  ),
                ],
              ),
            ),
          ),
          appBar: CustomAppBar(titleWidget: Text("Transaction Details",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
          ), dashboard: false, bgColor: AppColors.white, whiteBG: true, centerTitle: false, fontSize: 18.sp,),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                const Spacing.height(24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.grey,), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(PNGImages.transactionHistoryIcon, height: 40, width: 40,),
                          Text(amount, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),),
                        ],
                      ),
                      const Divider(),
                      KeyAndValueHolder(keys: "Transaction Date", value: transactionDate),
                      KeyAndValueHolder(keys: "Provider", value: provider),
                      KeyAndValueHolder(keys: "Phone Number", value: phoneNumber),
                      KeyAndValueHolder(keys: "Amount", value: amount),
                      KeyAndValueHolder(keys: "Transaction Number", value: transactionNumber),
                      KeyAndValueHolder(keys: "Status", value: status, valueColor: Colors.green,),
                    ],
                  ),
                ),
                const Spacing.height(83),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(PNGImages.support, height: 20, width: 20,),
                    const Spacing.width(5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Need help? ",
                            style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                color: Colors.black54, fontFamily: AppString.fontFamily1
                            ),
                          ),
                          TextSpan(text: "Contact Halal support",
                            style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                color: AppColors.primaryColor, fontFamily: AppString.fontFamily1
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
