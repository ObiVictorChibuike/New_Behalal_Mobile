import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownTextFieldWithIcon extends StatefulWidget {
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final List<double>? customHeights;
  final String? imagePath;
  const DropDownTextFieldWithIcon({super.key, this.items, this.onChanged, this.customHeights, this.imagePath});

  @override
  State<DropDownTextFieldWithIcon> createState() => _DropDownTextFieldWithIconState();
}

class _DropDownTextFieldWithIconState extends State<DropDownTextFieldWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(40),
                child: Image.asset(widget.imagePath ?? PNGImages.mtnLogo, height: 30, width: 30,),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined, size: 18, color: AppColors.black,),
            ],
          ),
          items: widget.items,
          onChanged: widget.onChanged,
          dropdownStyleData: DropdownStyleData(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.white,
            ),
            offset: const Offset(0, 8),
          ),
          menuItemStyleData: MenuItemStyleData(
            customHeights: widget.customHeights,
            padding: const EdgeInsets.only(left: 16, right: 16),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

