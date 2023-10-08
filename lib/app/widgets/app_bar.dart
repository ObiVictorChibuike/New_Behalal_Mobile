import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/presentation/home/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    required this.dashboard,
    this.bgColor,
    this.itemColor,
    this.whiteBG = false,
    this.callBackFunction,
    this.actions,
    this.leadingWidget,
    this.titleWidget,
    this.centerTitle,
    this.fontSize
  }) : super(key: key);

  final String? title;
  final bool dashboard;
  final bool whiteBG;
  final Color? bgColor;
  final bool? centerTitle;
  final Color? itemColor;
  final Widget? actions;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final double? fontSize;
  final void Function()? callBackFunction;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        backgroundColor: bgColor ?? AppColors.primaryColor,
        elevation: 0,
        leading:leadingWidget ??  Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: IconButton(
              icon: dashboard
                  ? SvgPicture.asset(
                      SVGImages.menu,
                      height: 40,
                      color: whiteBG ? AppColors.black : AppColors.white,
                    )
                  : GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                    child: Icon(
                        Icons.arrow_back_ios_new, size: 18,
                        color: whiteBG ? AppColors.black : AppColors.white,
                      ),
                  ),
              onPressed: dashboard
                  ? callBackFunction
                  : () {
                      Get.back();
                    }),
        ),
        title: titleWidget ?? Text(
          title ?? "",
          style: TextStyle(
            color: whiteBG ? AppColors.black : AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: fontSize ?? 16.sp,
          ),
        ),
        centerTitle: centerTitle ?? true,
        actions: [
          dashboard
              ? Padding(
                  padding: EdgeInsets.only(right: 30.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          SVGImages.message,
                          color: AppColors.white,
                        ),
                        onPressed: () => Get.to(() => const SupportView()),
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.notifications,
                      //     color: whiteBG ? AppColors.primaryColor : AppColors.white,
                      //     size: 26.h,
                      //   ),
                      //   onPressed: () => Get.to(() => const NotificationView()),
                      // ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 10.0.h),
                  child: actions ??
                      const SizedBox(
                        width: 0,
                      ),
                )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
