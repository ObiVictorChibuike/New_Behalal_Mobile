import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';

class RewardBox extends StatelessWidget {
  final List<Widget> children;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  const RewardBox({super.key, required this.children, required this.borderColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(top: 20, left: 12),
      decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children
        ],
      ),
    );
  }
}
