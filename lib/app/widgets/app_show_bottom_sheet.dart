import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';

class ShowAppBottomSheet{
  void showDismissibleBottomSheet({required BuildContext context, required List<Widget> children, double? height,
    required String title, double? horizontalPadding , double? verticalPadding}){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
        isScrollControlled: true, context: context,
        builder: (ctx) => Container(constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height/1.8,), width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15, vertical: verticalPadding ?? 5),
          decoration: const BoxDecoration(borderRadius:  BorderRadius.vertical(top: Radius.circular(20),), color: AppColors.white,),
          child: FractionallySizedBox(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(height: 5, width: 50,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
                const SizedBox(height: 10,),
                Text(title ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                const SizedBox(height: 10,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: children
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}