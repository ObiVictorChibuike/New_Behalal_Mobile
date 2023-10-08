
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatelessWidget {
  final TextEditingController? pinController;
  final ValueChanged<String>? onCompleted;
  final Function? onTap;
  const PinCode({super.key, this.pinController, this.onCompleted, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      controller: pinController,
      autoDisposeControllers: false,
      readOnly: true,
      pastedTextStyle: TextStyle(
        color: theme.textTheme.bodyText1!.color!,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      textStyle: TextStyle(color: theme.textTheme.bodyText1!.color!),
      cursorHeight: 15,
      validator: (String? value) {
        if (value == null || value == '') {
          return 'This field is required';
        }
        return null;
      },
      onTap: onTap,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldWidth: 20,
          activeColor: theme.textTheme.bodyText2!.color!,
          inactiveColor: theme.textTheme.bodyText2!.color!,
          selectedColor: theme.textTheme.bodyText2!.color!),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      onChanged: (value) {
        debugPrint(value);
        // setState(() {
        //   currentText = value;
        // });
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
