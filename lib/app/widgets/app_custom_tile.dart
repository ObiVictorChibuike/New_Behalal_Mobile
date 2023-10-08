import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCustomTile extends StatelessWidget {
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final Widget? tagWidget;
  final String? leadingLabel;
  final String? titleLabel;
  final String? subtitleLabel;
  final String? tagLabel;
  final Widget? actionWidget;
  final void Function()? onTap;
  const AppCustomTile({super.key, this.leadingWidget, this.titleWidget, this.subtitleWidget, this.tagWidget, this.leadingLabel, this.titleLabel, this.subtitleLabel, this.tagLabel, this.actionWidget, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white), padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leadingWidget ??
                    ClipRRect(borderRadius: BorderRadius.circular(40),
                        child: Image.asset(leadingLabel ?? "", height: 50, width: 50,)),
                    const Spacing.width(10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleWidget ?? Text(titleLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                            FontWeight.w500, fontSize: 16.sp, color:  AppColors.black),),
                          const SizedBox(width: 8,),
                          tagWidget ?? Container(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(color: tagLabel == "" ? Colors.transparent : const Color(0xffDEECFF), borderRadius: BorderRadius.circular(15)),
                            child: Text(tagLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                            FontWeight.w500, fontSize: 16.sp, color:  AppColors.black),),
                          )
                        ],
                      ),
                        subtitleWidget ?? Text(subtitleLabel ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),),
                      ],
                    ),
                  ],
                ),
                actionWidget ?? const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.black, size: 15,)
              ],
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
