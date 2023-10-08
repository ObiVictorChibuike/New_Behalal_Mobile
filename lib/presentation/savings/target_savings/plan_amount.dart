import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/savings_controller/saving_controller.dart';
import 'package:behalal/presentation/savings/target_savings/start_with_an_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PlanAmount extends StatelessWidget {
  const PlanAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavingController>(
        init: SavingController(),
        builder: (controller){
          return SafeArea(top: false, bottom: false,
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: Column(
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
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          children: [
                            Spacing.height(10.h),
                            Text("Do you have a target amount in mind?",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 36, fontWeight: FontWeight.w700),),
                            Text("We will help you monitor your target and break down your goal to make it easy to achieve.",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15, fontWeight: FontWeight.w400),),
                            Spacing.height(31.h),
                            TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 35, fontWeight: FontWeight.w700, color: AppColors.black),
                              controller: controller.amountController,
                              decoration: InputDecoration(hintText: "₦0.00",
                                hintStyle: Theme.of(context).textTheme.titleSmall!.
                                copyWith(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xffD9DBE9)),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: AppFlatButton(label: "No, I dont’t",
                                onPressed: (){},
                                textColor: AppColors.primaryColor,),
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
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const StartWithAnAmount()));
                          },
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
