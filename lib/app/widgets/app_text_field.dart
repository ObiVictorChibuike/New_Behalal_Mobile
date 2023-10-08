// ignore_for_file: prefer_const_constructors
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.initialValue,
    this.hintText,
    this.inputFormatters,
    this.controller,
    this.suffixIcon,
    this.textInputAction,
    this.validator,
    this.enabled,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLines,
    this.prefixText,
    // this.suffix,
    this.obscureText,
    this.keyboardType,
    this.errorText,
    this.label,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final bool? enabled;
  final String? errorText;
  final String? hintText;
  final String? initialValue;
  final String? label;
  final Color? fillColor;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: TextStyle(
                  color: fillColor != null ? AppColors.black : Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              )
            : SizedBox(),
        label != null ? Spacing.height(8) : SizedBox(),
        TextFormField(
          validator: validator,
          initialValue: initialValue,
          controller: controller,
          onChanged: onChanged,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: textInputAction ?? TextInputAction.done,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          enabled: enabled,
          // inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            hintStyle: TextStyle(
              color: Color(0xffB8B8B8),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: fillColor ?? Colors.white,
            contentPadding: EdgeInsets.all(20.0.h),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColors.lightPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColors.lightPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
