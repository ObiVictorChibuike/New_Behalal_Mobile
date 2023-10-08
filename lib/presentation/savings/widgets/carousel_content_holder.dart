import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselContentHolder extends StatelessWidget {
  final String assetPath;
  final String title;
  final String body;
  const CarouselContentHolder({super.key, required this.title, required this.body, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite, padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xffEBEBEB))),
        child: Row(
          children: [
            Image.asset(assetPath, height: 50, width: 50,),
            Spacing.width(8.w),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.black100, fontFamily: AppString.fontFamily1),),
                  Spacing.height(4.h),
                  SizedBox(width: 200,
                      child: Text(body, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyLarge!.
                      copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xff808A9A)),)),
                  Spacing.height(12.h),
                  Row(
                    children: [
                      Text("Create Now", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                      FontWeight.w500, fontSize: 12.sp, color:  AppColors.primaryColor),),
                      const Icon(Icons.arrow_forward_outlined, color: AppColors.primaryColor, size: 15,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
