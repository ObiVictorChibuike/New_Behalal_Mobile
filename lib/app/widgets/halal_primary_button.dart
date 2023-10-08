import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';

class HalalPrimaryButton extends StatelessWidget {
  final String? btnTitle;
  final Color? btnColor;
  final Color? titleColor;
  final void Function()? onTap;
  final double? btnHeight;
  final double? btnWidth;
  final double? borderRadius;
  final Color? buttonBorder;
  final double? btnTitleSize;
  final Widget? buttonWidget;
  const HalalPrimaryButton({Key? key, this.btnTitle, this.btnColor, this.titleColor, this.onTap, this.btnHeight, this.btnWidth, this.borderRadius, this.buttonBorder, this.btnTitleSize, this.buttonWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight ?? 48, width: btnWidth ?? double.maxFinite,
      decoration: BoxDecoration(
          color: btnColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 24.0)),
          border: Border.all(color: buttonBorder ??  AppColors.primaryColor)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          onTap: onTap,
          child: buttonWidget ?? Padding(
            padding: const EdgeInsets.only(
                top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                btnTitle ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: btnTitleSize ?? 12,
                  letterSpacing: 0.27,
                  color: titleColor ??  AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
