// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class AppPhoneTextField extends StatelessWidget {
  const AppPhoneTextField({
    Key? key,
    this.initialValue,
    this.hintText,
    this.inputFormatters,
    this.controller,
    this.suffixIcon,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.prefixText,
    // this.suffix,
    this.obscureText,
    this.errorText,
    this.label,
    this.prefixIcon,
    this.fillColor,
  }) : super(key: key);

  final void Function(PhoneNumber)? onChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final TextEditingController? controller;
  final String? errorText;
  final String? hintText;
  final String? initialValue;
  final String? label;
  final Color? fillColor;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
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
        IntlPhoneField(
          validator: validator, showDropdownIcon: false, disableLengthCheck: true,
          initialValue: initialValue,
          controller: controller,
          onChanged: onChanged, autovalidateMode: AutovalidateMode.always,
          textInputAction: textInputAction ?? TextInputAction.done,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
          initialCountryCode: 'NG',
          // inputFormatters: inputFormatters,
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
              borderSide: BorderSide(color: AppColors.lightPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
