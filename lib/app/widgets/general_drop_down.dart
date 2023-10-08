import 'package:behalal/app/color/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class GeneralDropDown extends StatefulWidget {
  final String hint;
  final void Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  final List<DropdownMenuItem<Object>>? items;
  final Widget? prefixIcon;
  final Color? borderColor;
  const GeneralDropDown({super.key, required this.hint, this.onChanged, this.validator, this.items, this.prefixIcon, this.borderColor});

  @override
  State<GeneralDropDown> createState() => _GeneralDropDownState();
}

class _GeneralDropDownState extends State<GeneralDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        counterText: " ",
        isDense: true, prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.only(left: 0, right: 10, top: 13.5, bottom: 13.5),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? AppColors.lightPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? AppColors.primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor ?? AppColors.lightPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(12),
          ),
      ),
      isExpanded: true,
      hint: Text(widget.hint, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xff868484), fontSize: 15)),
      items: widget.items,
      validator: widget.validator,
      onChanged: widget.onChanged,
      iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down, color: AppColors.black, size: 18,), iconSize: 30,),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
