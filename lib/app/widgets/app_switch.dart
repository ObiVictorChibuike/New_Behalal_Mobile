import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final AdvancedSwitchController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AdvancedSwitch(
        controller: controller,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        width: 50.0,
        height: 20.0,
        enabled: true,
        disabledOpacity: 4.5,
      ),
      title: Text(
        label,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
