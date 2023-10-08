import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShowLoaderBottomSheet{
  void showDismissibleBottomSheet({required BuildContext context, double? height, required String title}){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
        isScrollControlled: true, context: context,
        builder: (ctx) => Container(constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/2),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const BoxDecoration(borderRadius:  BorderRadius.vertical(top: Radius.circular(20),), color: AppColors.white,),
          child: FractionallySizedBox(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Container(height: 5, width: 50,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
                const SizedBox(height: 10,),
                Text(title ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(height: MediaQuery.of(context).size.height/8,),
                Center(
                  child: Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: AppColors.primaryColor,
                      secondRingColor: Colors.white,
                      thirdRingColor: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}