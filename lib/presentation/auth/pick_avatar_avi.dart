import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/local_session_manager/local_session_manager.dart';
import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class PickAvatarScreen extends StatefulWidget {
  const PickAvatarScreen({super.key});

  @override
  State<PickAvatarScreen> createState() => _PickAvatarScreenState();
}

class _PickAvatarScreenState extends State<PickAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(automaticallyImplyLeading: false, centerTitle: true,
              backgroundColor: AppColors.white, elevation: 0.0, title: Text(
                "Choose your avatar",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
              ),),
            body: FadeInUp(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(milliseconds: 1000),
              child: MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.aviList.length,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      LocalSessionManager localSessionManager = LocalSessionManager();
                      Navigator.pushNamed(context, Routes.confirmAviSelection, arguments: controller.aviList[index]);
                      localSessionManager.authUserAvatar = controller.aviList[index];
                    },
                    child: SizedBox(
                      height: Random().nextInt(150) + 50.5,
                      child: Center(
                        child: Image.asset(controller.aviList[index]),
                      ),
                    ),
                  );
                },
              ),
            )
        ),
      );
    });
  }
}
