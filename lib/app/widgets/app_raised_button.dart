import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.onBoarding = false,
    this.withIcons = false,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.color,
    this.textColor,
    this.borderColor = Colors.transparent,
    this.elevation,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);
  final Color? borderColor;

  final double? borderRadius;
  final Color? color;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? elevation;
  final double? fontSize;
  final bool onBoarding;
  final bool withIcons;
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 3.0,
        primary: color ?? AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      onPressed: onPressed,
      child: withIcons
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefixIcon ?? const Spacing.width(0),
                const Spacing.width(3),
                Text(
                  label,
                  style: TextStyle(
                    color: onBoarding ? AppColors.primaryColor : AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacing.width(10),
                suffixIcon ?? const Spacing.width(0),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                label,
                style: TextStyle(
                  color: onBoarding ? AppColors.primaryColor : AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
    );
  }
}

class AppFlatButton extends StatelessWidget {
  const AppFlatButton({
    Key? key,
    required this.label,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  const AppFlatButton.empty()
      : label = '',
        textColor = Colors.transparent,
        onPressed = null;

  final Function()? onPressed;
  final String label;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
