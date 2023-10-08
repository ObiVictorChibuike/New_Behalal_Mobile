import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/loader_bottom_sheet.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:behalal/presentation/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loaderDialog({required BuildContext context}){
  ShowLoaderBottomSheet().showDismissibleBottomSheet(
      context: context,
      title: "Processing Transaction",
      height: MediaQuery.of(context).size.height/2
  );
}

void showBillSuccessDialog({required BuildContext context, required String smartCardNumber, required String provider}){
  ShowAppBottomSheet().showDismissibleBottomSheet(
      context: context, children: [
        Image.asset(PNGImages.success, height: 35, width: 35,),
     const Spacing.height(20),
    Text("Successful", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.w400),),
    const Spacing.height(16),
    Text("Your $provider premium subscription was \nsuccessful", textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 16),),
    const Spacing.height(32),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("SmartCard Number", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.w400),),
        Text(smartCardNumber, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontSize: 12, fontWeight: FontWeight.w400),),
      ],
    ),
    const Spacing.height(6),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Bonus  Earned", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.w400),),
        Text("+₦5 Cashback", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w400),),
      ],
    ),
    const Spacing.height(78),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        HalalPrimaryButton(
          buttonBorder: AppColors.primaryColor,
          btnTitle: "Done", btnColor: AppColors.primaryColor,
          onTap: (){
            Get.back();
            Get.offAll(()=> const DashBoardView());
          },
        ),
      ],
    ),
  ], title: "", height: MediaQuery.of(context).size.height/2);
}

void errorDialog({required BuildContext context, required String smartCardNumber, required String provider}){
  ShowAppBottomSheet().showDismissibleBottomSheet(
      context: context, children: [
    Image.asset(PNGImages.errorIcon, height: 35, width: 35,),
    const Spacing.height(20),
    Text("Oops!", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.w400),),
    const Spacing.height(8),
    Text("There is a network error", textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 16),),
  ], title: "", height: MediaQuery.of(context).size.height/2);
}