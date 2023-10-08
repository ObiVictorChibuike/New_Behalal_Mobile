import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavingsAppbar extends StatelessWidget {
  final Widget actionIcon;
  final String avatarPath;
  const SavingsAppbar({super.key, required this.avatarPath, required this.actionIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white, padding: EdgeInsets.only(bottom: 10.h, top: 35.h,),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50, width: 50,
              child: Image.asset(avatarPath,
                height: 60, width: 60,
                fit: BoxFit.cover,
              )
          ),
          Text("My Savings", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),),
          actionIcon
        ],
      ),
    );
  }
}
