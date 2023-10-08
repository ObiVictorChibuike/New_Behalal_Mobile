import 'dart:ui';
import 'package:behalal/app/color/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({super.key});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height/1.5, width: double.infinity,
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: const BoxDecoration(color: AppColors.white),
              padding: const EdgeInsets.all(50),
              child: NumericKeyboard(
                  onKeyboardTap: (String text) {},
                  rightButtonFn: () {
                    HapticFeedback.heavyImpact();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2.0,
                              sigmaY: 2.0,
                            ),
                            child: CupertinoAlertDialog(
                              title: const Text("Verification Successful"),
                              content: Text(
                                "Thank you for verifying your phone number, proceed with your registration ",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 14,
                                      fontFamily: 'PushPenny',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onPressed: () {


                                  },
                                ),
                              ],
                            )));
                  }),
            )
          ],
        ),
      ),
    );
  }
}


typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Widget? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Widget? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
        required this.onKeyboardTap,
        this.textColor = Colors.black,
        this.rightButtonFn,
        this.rightIcon,
        this.leftButtonFn,
        this.leftIcon,
        this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite, decoration: BoxDecoration(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1)),
      //padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _calcButton('1'),
                 SizedBox(width: 10.w,),
                 _calcButton('2'),
                 SizedBox(width: 10.w,),
                 _calcButton('3'),
               ],
             )
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _calcButton('4'),
                  SizedBox(width: 10.w,),
                  _calcButton('5'),
                  SizedBox(width: 10.w,),
                  _calcButton('6'),
                ],
              )
            ],
          ),
          ButtonBar(
            buttonMinWidth: double.infinity,
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _calcButton('7'),
                  SizedBox(width: 10.w,),
                  _calcButton('8'),
                  SizedBox(width: 10.w,),
                  _calcButton('9'),
                ],
              )
            ],
          ),
          ButtonBar(
            buttonMinWidth: double.infinity,
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              Row(
                children: [
                  InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: widget.leftButtonFn,
                      child: Container(
                          alignment: Alignment.center,
                          width: 70,
                          height: 45,
                          child: widget.leftIcon)),
                  SizedBox(width: 10.w,),
                  _calcButton('0'),
                  SizedBox(width: 10.w,),
                  InkWell(
                      borderRadius: BorderRadius.circular(45),
                      onTap: widget.rightButtonFn,
                      child: Container(
                        alignment: Alignment.center,
                        decoration:   BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: AppColors.grey),
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1)
                        ),
                        width: 90,
                        height: 45,
                        child: widget.rightIcon ??   Icon(Icons.arrow_back,color: Theme.of(context).textTheme.bodyText1!.color! ,),))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          decoration:   BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.grey),
              color: AppColors.white
          ),
          width: 90,
          height: 45,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ));
  }
}

