import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';

class KeyAndValueHolder extends StatelessWidget {
  final String keys;
  final String value;
  final Color? valueColor;
  final Color? keyColor;
  const KeyAndValueHolder({super.key, required this.keys, required this.value, this.valueColor, this.keyColor});

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.white, width: double.maxFinite, padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keys, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: keyColor ?? const Color(0xff808A9A), fontSize: 12, fontWeight: FontWeight.w500),),
          Text(value, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: valueColor ?? const Color(0xff070707), fontWeight: FontWeight.w500, fontSize: 12),)
        ],
      ),
    );
  }
}
