import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/cupertino.dart';

class ButtonWithLabel extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final double? height;
  final double? width;
  final Decoration? decoration;
  const ButtonWithLabel({super.key, required this.icon, required this.title, this.height, this.width, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height ?? 0, width: width ?? 0, decoration: decoration,
          child: Center(
            child: icon,
          ),
        ),
        const Spacing.height(10),
        title,
      ],
    );
  }
}
