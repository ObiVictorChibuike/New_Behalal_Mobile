import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'spacing.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.suffixIcon,
    this.errorText,
    this.hintText,
    this.controller,
    this.fillColor,
    this.label,
  }) : super(key: key);

  final Function(String?) onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final Color? fillColor;
  final String? hintText;
  final List<String> items;
  final String? label;
  final Widget? suffixIcon;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            : const SizedBox(),
        label != null ? const Spacing.height(12) : const SizedBox(),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField(
            isExpanded: true,
            items: items.map(
              (String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
            value: value,
            validator: (value) => value == null ? 'Field required' : null,
            dropdownColor: theme.colorScheme.surface,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              // hintText: hintText,
              errorText: errorText,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                color: const Color(0xffB8B8B8),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: fillColor ?? Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.w),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightPrimaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(5),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
