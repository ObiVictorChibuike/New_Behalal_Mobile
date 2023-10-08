import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    Key? key,
    required this.onChanged,
    this.label,
    required this.isChecked, required this.isSwitch,
  }) : super(key: key);

  final Function(bool?) onChanged;
  final Widget? label;
  final bool isChecked;
  final bool isSwitch;

  @override
  Widget build(BuildContext context) {
    return isSwitch == true ? SwitchListTile.adaptive(
      activeColor: Colors.white,
      // fillColor: MaterialStateProperty.resolveWith(Colors.red),
      value: isChecked,
      // shape: const CircleBorder(),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      onChanged: (value) {
        onChanged(value);
      },
      title: label ??
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "By clicking on the button below, I confirm to have to read the ",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,fontFamily: AppString.fontFamily1
                  ),
                ),
                TextSpan(
                  text: "Terms and Condition ",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,fontFamily: AppString.fontFamily1
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print('aaaaaaaaaaaaa');
                    },
                ),
                TextSpan(
                  text: "of Halal and give rights to them over my data.",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54, fontFamily: AppString.fontFamily1
                  ),
                ),
              ],
            ),
          ),
    ) : CheckboxListTile(
      checkColor: Colors.white,
      // fillColor: MaterialStateProperty.resolveWith(Colors.red),
      value: isChecked,
      // shape: const CircleBorder(),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      onChanged: (value) {
        onChanged(value);
      },
      title: label ??
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "I agree to the ",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,fontFamily: AppString.fontFamily1
                  ),
                ),
                TextSpan(
                  text: "Terms and Condition ",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,fontFamily: AppString.fontFamily1
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print('aaaaaaaaaaaaa');
                    },
                ),
                TextSpan(
                  text: "and ",
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,fontFamily: AppString.fontFamily1
                  ),
                ),
                TextSpan(
                  text: "\nPrivacy Policy.",
                  style:  TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,fontFamily: AppString.fontFamily1
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print('bbbbbbbbbbbbbbbbb');
                    },
                ),
              ],
            ),
          ),
    );
  }
}
