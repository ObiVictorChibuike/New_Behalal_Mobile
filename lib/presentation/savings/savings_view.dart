import 'dart:developer';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/reward_box.dart';
import 'package:behalal/controller/home_controllers/home_controller.dart';
import 'package:behalal/controller/savings_controller/saving_controller.dart';
import 'package:behalal/presentation/savings/savings_details.dart';
import 'package:behalal/presentation/savings/savings_type.dart';
import 'package:behalal/presentation/savings/widgets/saving_type_card.dart';
import 'package:behalal/presentation/savings/widgets/savings_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SavingScreen extends StatefulWidget {
  const SavingScreen({super.key});

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  final homeController = Get.find<HomeController>();
  final savingController = Get.put(SavingController());
  PageController controller = PageController();
  int currentPage = 0;
  Widget dotIndicator(){
    return Container(
      height: 8, width: 8,
      decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.white,
          extendBodyBehindAppBar: true,
          floatingActionButton: FloatingActionButton(
            child: const Center(child: Icon(Icons.add, color: AppColors.white,),),
              onPressed: (){
                Get.to(()=> const SavingsType());
          }),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                child: SavingsAppbar(
                    avatarPath: homeController.userAvatar == "" ? AppString.aviPath : homeController.userAvatar!,
                    actionIcon: SvgPicture.asset(SVGImages.notification)
                ),
              ),
              CarouselSlider(
                items: [
                  SavingsTypeCard(
                      title: Text("Total Savings Balance", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),),
                      amount: Row(children: [
                          Text("₦500.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp, color:  AppColors.white),),
                          Spacing.width(6.w),
                          const Icon(Iconsax.eye_copy, color: AppColors.white, size: 18,)
                        ],
                      ),
                      actionLabel: "Withdraw Savings",
                    color: AppColors.primaryColor, actionIcon: Image.asset(PNGImages.sell,height: 20, width: 20,),
                  ),
                  SavingsTypeCard(
                      title: Text("Emergency Savings ⏳", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),),
                      amount: Row(children: [
                        Text("₦500.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp, color:  AppColors.white),),
                        Spacing.width(6.w),
                        const Icon(Iconsax.eye_copy, color: AppColors.white, size: 18,)
                      ],
                      ),
                      actionLabel: "Start Saving",
                      color: AppColors.palePurple, actionIcon:  Image.asset(PNGImages.plus,height: 20, width: 20,),
                  ),
                  SavingsTypeCard(
                      title: Text("Total Halal Safelock 🔒", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),),
                      amount: Row(children: [
                        Text("₦500.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp, color:  AppColors.white),),
                        Spacing.width(6.w),
                        const Icon(Iconsax.eye_copy, color: AppColors.white, size: 18,)
                      ],
                      ),
                      actionLabel: "Lock Fund Now",
                      color: AppColors.green, actionIcon: Image.asset(PNGImages.plus, height: 20, width: 20,),
                  ),
                ],
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    currentPage = index;
                    setState(() {});
                  },
                  height: 160.h, enlargeCenterPage: false,
                  autoPlay: false, aspectRatio: 16 / 4,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true, autoPlayAnimationDuration:
                  const Duration(milliseconds: 400), viewportFraction: 1.0,
                ),
              ),
              const Spacing.height(12),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSmoothIndicator(
                    activeIndex: currentPage,
                    count: 3,
                    effect: const ExpandingDotsEffect(dotHeight: 5, dotWidth: 5, activeDotColor: AppColors.primaryColor),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const Spacing.height(21),
                        GetBuilder<SavingController>(
                          init: SavingController(),
                            builder: (controller){
                          return controller.savings.isEmpty ?
                              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacing.height(100.h),
                                  Image.asset(PNGImages.wallet, height: 64.h, width: 64.w,),
                                  Spacing.height(16.h),
                                  Text("No Savings Yet", style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 20),),
                                  Spacing.height(16.h),
                                  SizedBox(width: 300.w,
                                      child: Text("Click the plus button now to create a savings and begin your journey to halal returns", textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: const Color(0xffD9DBE9)),
                                      )),
                                  Spacing.height(38.h),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "Don’t have a savings yet? ",
                                          style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                              color: Colors.black54, fontFamily: AppString.fontFamily1
                                          ),
                                        ),
                                        TextSpan(text: "Create Now",
                                          style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColor, fontFamily: AppString.fontFamily1
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                          Get.to(()=> const SavingsType());
                                            },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ) :
                          Column(
                            children: [
                              ...List.generate(controller.savings.length, (index){
                                final data = controller.savings[index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SavingsDetails(data: data, index: index,)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 12), width: double.infinity,
                                    decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.grey.withOpacity(0.1)),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 0, child: Image.asset(
                                          index != 0 && index != 1 ? PNGImages.tree : PNGImages.piggy,
                                          height: 130.h,
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(data["title"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                          FontWeight.w600, fontSize: 18.sp, color:  AppColors.black100),),
                                                          index != 0 ? const Spacing.width(5) : const SizedBox.shrink(),
                                                          index != 0 ? SvgPicture.asset( SVGImages.lock) : const SizedBox.shrink()
                                                        ],
                                                      ),
                                                      Spacing.height(6.h),
                                                      Row(mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: index == 0 ? AppColors.palePurple.withOpacity(0.1) :
                                                            index == 1 ? AppColors.green.withOpacity(0.1) : AppColors.primaryColor.withOpacity(0.1)),
                                                            child: Center(child: Text(data["savings_type"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                            FontWeight.w500, fontSize: 10.sp, color: index == 0 ? AppColors.palePurple :
                                                            index == 1 ? AppColors.green : AppColors.primaryColor),),),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(30)),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          dotIndicator(),
                                                          const Spacing.width(3),
                                                          Text("Active", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                          FontWeight.w400, fontSize: 12.sp, color:  AppColors.green),),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Spacing.height(18.h),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(data["buttonLabel"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                      FontWeight.w400, fontSize: 10.sp, color:  AppColors.black300),),
                                                      Text(data["amount"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                      FontWeight.w500, fontSize: 14.sp, color:  AppColors.black),),
                                                    ],
                                                  ),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(data["balanceLabel"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                      FontWeight.w400, fontSize: 10.sp, color:  AppColors.black300),),
                                                      Text(data["balance"] ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                      FontWeight.w500, fontSize: 14.sp, color:  AppColors.black),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
