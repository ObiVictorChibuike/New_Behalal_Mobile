import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'components.dart';

class AppDateTimePicker extends StatelessWidget {
  const AppDateTimePicker({
    Key? key,
    required this.onDateChange,
    required this.selectedDate,
    this.initialDate,
    this.lastDate,
    this.firstDate,
    required this.label,
  }) : super(key: key);

  final Function(DateTime)? onDateChange;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final String? label;
  final DateTime? lastDate;
  final String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: TextStyle(
                  // color: fillColor != null ? AppColors.black : Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                ),
              )
            : const SizedBox(),
        label != null ? const Spacing.height(8) : const SizedBox(),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.lightPrimaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text(
              selectedDate ?? 'Select date',
              style: TextStyle(
                color: selectedDate != null ? AppColors.black : const Color(0xffB8B8B8),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          onTap: () {
            Get.bottomSheet(
              AppBottomSheet(
                content: CalendarDatePicker(
                  firstDate: firstDate ?? DateTime.now(),
                  initialDate: initialDate ?? DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()),
                  lastDate: lastDate ?? DateTime(2030),
                  onDateChanged: onDateChange!,
                ),
                title: '',
              ),
            );
          },
        ),
      ],
    );
  }
}
