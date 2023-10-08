import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTransactionTile extends StatelessWidget {
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final Widget? tagWidget;
  final String? leadingLabel;
  final String? titleLabel;
  final String? subtitleLabel;
  final String? tagLabel;
  final Widget? actionWidget;
  const AppTransactionTile({super.key, this.leadingWidget, this.titleWidget, this.subtitleWidget, this.tagWidget, this.leadingLabel, this.titleLabel, this.subtitleLabel, this.tagLabel, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return      Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.white), padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  leadingWidget ?? ClipRRect(borderRadius: BorderRadius.circular(40),
                      child: Image.asset(leadingLabel ?? "", height: 40, width: 40,)),
                  const Spacing.width(10),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget ?? Text(titleLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                      FontWeight.w700, fontSize: 14.sp, color:  AppColors.black),),
                     subtitleWidget ??  Text(subtitleLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                      FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),),
                    ],
                  ),
                ],
              ),
              tagWidget ?? Text(tagLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
              FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),),
            ],
          ),
        ),
        const Divider()
      ],);
  }
}
