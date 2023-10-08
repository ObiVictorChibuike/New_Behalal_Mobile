import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmAviSelection extends StatefulWidget {
  final String selectedAviPath;
  const ConfirmAviSelection({super.key, required this.selectedAviPath});

  @override
  State<ConfirmAviSelection> createState() => _ConfirmAviSelectionState();
}

class _ConfirmAviSelectionState extends State<ConfirmAviSelection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height/18, width: MediaQuery.of(context).size.width, margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AppButton(elevation: 0.0, label: 'Continue', borderRadius: 30, borderColor: AppColors.primaryColor, color: AppColors.primaryColor,
              onPressed: () {
                Navigator.pushNamed(context, Routes.register, arguments: widget.selectedAviPath);
              },
            ),
          ),
          body: FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 1000),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(tag: "profile_photo", child: Image.asset(widget.selectedAviPath, height: 400, width: 400,)),
                Text("Great Choice!", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 20.sp,),)
              ],
            ),
          ),
        )
    );
  }
}
