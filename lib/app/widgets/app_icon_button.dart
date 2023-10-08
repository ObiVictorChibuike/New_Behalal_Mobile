import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/spacing.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? spacing;
  final void Function()? onTap;
  const AppIconButton({super.key, required this.icon, required this.label, this.padding, this.color, this.spacing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            color: color ?? AppColors.white),
        child: Row(
          children: [
            icon,
            const Spacing.width(6),
            label
          ],
        ),
      ),
    );
  }
}
