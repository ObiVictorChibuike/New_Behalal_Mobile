import 'package:behalal/app/color/colors.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordCheckIndicator extends StatefulWidget {
  const PasswordCheckIndicator({super.key});

  @override
  State<PasswordCheckIndicator> createState() => _PasswordCheckIndicatorState();
}

class _PasswordCheckIndicatorState extends State<PasswordCheckIndicator> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
        builder: (controller){
      return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(decoration: const BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.check_circle_outline_sharp, color: (controller.upTo8Characters) ? AppColors.requirementMet : AppColors.requirementNotMet, size: 15,),
                        SizedBox(width: 3.w,),
                        const Text(
                          "At least 8 characters strong",
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )),
              SizedBox(width: 3.w),
              Container(
                decoration: const BoxDecoration(color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.h, horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.check_circle_outline_sharp, color: (controller.lowerCase) ? AppColors.requirementMet : AppColors.requirementNotMet, size: 15,),
                      SizedBox(width: 3.w,),
                      const Text(
                        "One lower case character",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: const BoxDecoration(color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.check_circle_outline_sharp, color: (controller.upperCase) ? AppColors.requirementMet : AppColors.requirementNotMet, size: 15,),
                        SizedBox(width: 3.w,),
                        const Text("One upper case ", textAlign: TextAlign.center, style: TextStyle(color: AppColors.black, fontSize: 10, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                width: 3.w,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.h, horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.check_circle_outline_sharp,
                        color: (controller.numbers)
                            ? AppColors.requirementMet
                            : AppColors.requirementNotMet,
                        size: 15,
                      ),
                      SizedBox(width: 3.w,),
                      const Text(
                        "One number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.h, horizontal: 2.w),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline_sharp, color: (controller.symbolSpecial) ? AppColors.requirementMet : AppColors.requirementNotMet, size: 15,),
                        SizedBox(width: 3.w,),
                        const Text(
                          "A symbol or special character",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      );
    });
  }
}
