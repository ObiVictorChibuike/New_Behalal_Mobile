import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/presentation/savings/target_savings/plan_name.dart';
import 'package:behalal/presentation/savings/widgets/carousel_content_holder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SavingsType extends StatefulWidget {
  const SavingsType({super.key});

  @override
  State<SavingsType> createState() => _SavingsTypeState();
}

class _SavingsTypeState extends State<SavingsType> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacing.height(30.h),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Choose Savings Type", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),),
                      ),
                      Spacing.height(22.h),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PlanSaving()));
                        },
                        child: const CarouselContentHolder(
                            title: "Target Savings",
                            body: "Save towards a goal with halal and earn halal returns in the long or short term",
                            assetPath: PNGImages.slideImage1
                        ),
                      ),
                      Spacing.height(12.h),
                      const CarouselContentHolder(
                          title: "Spend to save",
                          body: "Save a percentage of the amount whenever you spend on something",
                          assetPath: PNGImages.slideImage2
                      ),
                      Spacing.height(12.h),
                      const CarouselContentHolder(
                          title: "Save To Start",
                          body: "Save a percentage of the amount whenever you spend on something",
                          assetPath: PNGImages.slideImage4,
                      ),
                      Spacing.height(12.h),
                      const CarouselContentHolder(
                          title: "Save Small Small",
                          body: "Save a percentage of the amount whenever you spend on something",
                          assetPath: PNGImages.slideImage3
                      ),
                      Spacing.height(12.h),
                      const CarouselContentHolder(
                          title: "Save Now, Buy Later",
                          body: "Save a percentage of the amount whenever you spend on something",
                          assetPath: PNGImages.slideImage5
                      ),
                      Spacing.height(44.h),
                    ]
                )
            )
        )
    );
  }
}
