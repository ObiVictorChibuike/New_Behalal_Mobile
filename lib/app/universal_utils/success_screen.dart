import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final void Function()? onTap;
  final String? buttonLabel;
  const SuccessScreen({super.key, this.onTap, this.buttonLabel});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: Container(
            color: AppColors.white, height: 200, width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 135, top: 22),
              child: HalalPrimaryButton(
                  btnHeight: 45, btnWidth: double.maxFinite, btnTitle: widget.buttonLabel ?? "",
                  onTap: widget.onTap
              ),
            ),
          ),
          body: Container(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.waterMark))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(PNGImages.hurray, height: 100, width: 100,),
                    const Spacing.height(25),
                    Text("Congratulations! ", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 20, color: AppColors.black),),
                    const Spacing.height(10),
                    Text("Your Halal account has been set up", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight:
                    FontWeight.w400, fontSize: 16),),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
