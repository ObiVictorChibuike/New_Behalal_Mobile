import 'package:behalal/app/color/colors.dart';
import 'package:flutter/material.dart';

class HistoryFilter extends StatefulWidget {
  const HistoryFilter({super.key});

  @override
  State<HistoryFilter> createState() => _HistoryFilterState();
}

class _HistoryFilterState extends State<HistoryFilter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              
            ],
          ),
        )
    );
  }
}
