import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/controller/savings_controller/saving_controller.dart';
import 'package:behalal/presentation/savings/target_savings/plan_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PlanSaving extends StatelessWidget {
  const PlanSaving({super.key});

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
                        Text("What would you like to save for ?",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 36, fontWeight: FontWeight.w700),),
                        Text("Give your savings plan a descriptive name. For example, new car bi’idnillah",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15, fontWeight: FontWeight.w400),),
                        Spacing.height(31.h),
                        AppTextField(
                          label: null, controller: controller.planNameController,
                          hintText: 'Plan Name',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: controller.onPlanNameChanged,
                          validator: controller.validateNotEmpty,
                        ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  PlanAmount()));
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
