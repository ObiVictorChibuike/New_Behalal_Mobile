import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavingsTypeCard extends StatelessWidget {
  final Widget title;
  final Widget amount;
  final String actionLabel;
  final Color color;
  final Widget actionIcon;
  const SavingsTypeCard({super.key, required this.title, required this.amount, required this.actionLabel, required this.color, required this.actionIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.0.w),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        children: [
          Positioned(right: 0.0, child: Image.asset(PNGImages.halalSavingsIcon, height: 180.h,)),
          Padding(
            padding: EdgeInsets.only(top: 24.h, bottom: 20.h, left: 16.5.w, right: 16.5.w),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                Spacing.height(8.h),
                amount,
                Spacing.height(18.h),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.transparent, border: Border.all(color: AppColors.white)),
                      child: Center(
                        child: Row(
                          children: [
                            actionIcon,
                            const Spacing.width(2),
                            Text(actionLabel, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                            FontWeight.w400, fontSize: 16.sp, color: AppColors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
