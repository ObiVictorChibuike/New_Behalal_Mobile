import 'dart:io';

import 'package:behalal/app/color/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showExpiredsessionDialog(
    BuildContext context, String errorMessage, String title, void Function()? onPressed) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('$title',  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor, fontSize: 16),),
          content: Text(errorMessage, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 13),),
          actions: [
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text('Ok', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor, fontSize: 14),),
            ),
            CupertinoDialogAction(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor, fontSize: 14),),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor, fontSize: 16),),
          content: Text(errorMessage, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 13, ),),
          contentTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 13, fontFamily: "Work Sans",),
          actions: [
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text('Ok', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor),),
            ),
          ],
        );
      },
    );
  }
}