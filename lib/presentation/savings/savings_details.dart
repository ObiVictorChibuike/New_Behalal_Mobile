import 'dart:developer';

import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/presentation/savings/savings_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SavingsDetails extends StatelessWidget {
  final Map<String, String> data;
  final int index;
  const SavingsDetails({super.key, required this.data, required this.index,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0.0, backgroundColor: AppColors.white,
            leading: GestureDetector(
              onTap: (){
                log("message");
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(SVGImages.arrow,),
              ),
            ),
            title: Row(
              children: [
                Text(data["title"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                FontWeight.w400, fontSize: 18.sp, color:  AppColors.black100),),
                Spacing.width(5.w),
                Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: index == 0 ? AppColors.palePurple.withOpacity(0.1) :
                  index == 1 ? AppColors.green.withOpacity(0.1) : AppColors.primaryColor.withOpacity(0.1)),
                  child: Center(child: Text(data["savings_type"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                  FontWeight.w500, fontSize: 10.sp, color: index == 0 ? AppColors.palePurple :
                  index == 1 ? AppColors.green : AppColors.primaryColor),),),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.height(20.h),
                Align(alignment: Alignment.center,
                  child: Text("Total Savings Balance", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                  FontWeight.w400, fontSize: 18.sp, color:  AppColors.black100),),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("₦50,000.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 24.sp, color:  AppColors.black),),
                  Spacing.width(6.w),
                  const Icon(Iconsax.eye_copy, color: AppColors.black, size: 18,)],
                ),
                SvgPicture.asset(SVGImages.chart),
                Text("Target Amount ₦120,000", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff394455), fontSize: 14.sp, ),),
                Spacing.height(10.h),
                 LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(3),
                  value: 0.3,
                   backgroundColor: AppColors.palePurple.withOpacity(0.2), // Set the background color
                   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.black),
                ),
                Spacing.height(25.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.grey.withOpacity(0.1)), borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    children: [
                      const Text("⚡"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Trigger ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff394455), fontSize: 14.sp, ),),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: "Automatically save ",
                                      style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                          color: Colors.black54, fontFamily: AppString.fontFamily1
                                      ),
                                    ),
                                    TextSpan(text: "Create Now",
                                      style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                          color: AppColors.primaryColor, fontFamily: AppString.fontFamily1
                                      ),
                                      children: [
                                        TextSpan(text: " transactions. Max Amount not specified",
                                          style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                              color: Colors.black54, fontFamily: AppString.fontFamily1
                                          ),
                                        ),
                                      ],
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.height(21.h),
                Text("Transaction History", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.greyValley, fontSize: 14.sp, ),),
                 Spacing.height(5.h),
                ...List.generate(7, (index){
                  return AppTransactionTile(
                    leadingWidget: SvgPicture.asset(SVGImages.transactions),
                    titleWidget: Text("₦20,000.00", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black200, fontSize: 14.sp),),
                    subtitleWidget: Text("Automatic Top up", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black300, fontSize: 12.sp),),
                    tagWidget: Text("Sep 23, 2022", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.greyValley, fontSize: 12.sp),),
                  );
                })
              ],
            ),
          ),
        )
    );
  }
}
