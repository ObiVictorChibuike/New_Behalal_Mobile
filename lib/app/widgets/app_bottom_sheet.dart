import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    Key? key,
    required this.content,
    required this.title,
    // this.form = false,
  }) : super(key: key);

  final Widget content;
  final String title;
  // final bool form;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Center(
              child: Text(
                title,
                style: theme.textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () => Null,
              icon: const Icon(Icons.cancel, size: 1, color: AppColors.white),
            ),
            trailing: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.cancel,
                size: 30.h,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(child: content),
              ),
            ],
          )
        ],
      ),
    );
  }
}
