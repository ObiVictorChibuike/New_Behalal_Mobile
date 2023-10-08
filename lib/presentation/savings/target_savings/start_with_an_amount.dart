import 'dart:developer';

import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/savings_controller/saving_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class StartWithAnAmount extends StatelessWidget {
  const StartWithAnAmount({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SavingController>(
        init: SavingController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacing.height(31.h),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(SVGImages.arrow,),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacing.height(10.h),
                            Text("Start with an amount",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 36, fontWeight: FontWeight.w700),),
                            Spacing.height(8.h),
                            Text("How much would you like to start with?",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15, fontWeight: FontWeight.w400),),
                            Spacing.height(31.h),
                            GroupButton(
                              options: GroupButtonOptions(
                                  selectedTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white, fontSize: 16),
                                  unselectedTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff394455), fontSize: 16),
                                  unselectedColor: const Color(0xffFCFCFC),
                                  mainGroupAlignment: MainGroupAlignment.start,
                                  unselectedBorderColor: AppColors.white,
                                  crossGroupAlignment: CrossGroupAlignment.start,
                                  borderRadius: BorderRadius.circular(25),
                                  selectedColor: AppColors.primaryColor,
                                  buttonHeight: 40, selectedBorderColor: AppColors.primaryColor,
                                  buttonWidth: MediaQuery.of(context).size.width / 3.6),
                              isRadio: true,
                              onSelected: (String value, index, isSelected) {
                                if(value.toString() == "Custom"){
                                  controller.numberPadDialog(context: context);
                                }
                              },
                              buttons: const [
                                "₦ 1,000",
                                "₦ 5,000",
                                "₦ 10,000",
                                "₦ 20,000",
                                "₦ 100,000",
                                "Custom"
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                          elevation: 0.0, label: 'Next', borderRadius: 30,
                          borderColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Spacing.height(31.h),
                  ],
                ),
              )
          );
        });
  }
}
