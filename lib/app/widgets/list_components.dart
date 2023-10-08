import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'spacing.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.title,
    this.description = 'We can\'t find any record from\nyour history',
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No $title Found',
          style: textTheme.headline6?.copyWith(
            fontSize: 19.sp,
          ),
        ),
        const Spacing.height(8),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacing.height(24),
        // ),
      ],
    );
  }
}

class LoadingList extends StatelessWidget {
  const LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) => Shimmer.fromColors(
        baseColor: AppColors.lightPrimaryColor,
        highlightColor: AppColors.primaryColor,
        child: ListView.builder(
          itemCount: constraint.maxHeight ~/ 65.h,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .080,
              child: OutlinedButton(
                onPressed: () => Null, //Get.toNamed(Routes.savingsDetailsView),
                style: OutlinedButton.styleFrom(
                  primary: Colors.blue,
                  backgroundColor: const Color(0xffEBF4FF),
                  side: const BorderSide(color: AppColors.primaryColor, width: 0.5),
                ),
                child: const Text('Loading'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
