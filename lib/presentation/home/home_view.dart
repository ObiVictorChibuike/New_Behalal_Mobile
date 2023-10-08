import 'dart:async';
import 'dart:developer';
import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/constants/strings.dart';
import 'package:behalal/app/local_session_manager/local_session_manager.dart';
import 'package:behalal/app/widgets/app_custom_tile.dart';
import 'package:behalal/app/widgets/app_icon_button.dart';
import 'package:behalal/app/widgets/app_show_bottom_sheet.dart';
import 'package:behalal/app/widgets/button_with_label.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:behalal/app/widgets/halal_primary_button.dart';
import 'package:behalal/app/widgets/reward_box.dart';
import 'package:behalal/app/widgets/transaction_tile.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/controller/home_controllers/home_controller.dart';
import 'package:behalal/presentation/bills/bank_transfer.dart';
import 'package:behalal/presentation/bills/buy_airtime.dart';
import 'package:behalal/presentation/bills/buy_cable.dart';
import 'package:behalal/presentation/bills/buy_data.dart';
import 'package:behalal/presentation/bills/buy_electricity.dart';
import 'package:behalal/presentation/bills/p2p_transfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LocalSessionManager localSessionManager = LocalSessionManager();
  final homeController = Get.put(HomeController());
  final billController = Get.put(BillController());

  Timer interval(Duration duration, func) {
    Timer function() {
      Timer timer = Timer(duration, function);
      func(timer);
      return timer;
    }
    return Timer(duration, function);
  }

  checkEmailVerification(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(homeController.dashBoardResponseModel?.data?.userdetail?.email == null || homeController.dashBoardResponseModel?.data?.userdetail?.email  == ""){
        interval(const Duration(minutes: 1), (timer) {
          _emailReminderDialog(context: context);
          // if (homeController.emailPromptCount > 0) timer.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    homeController.getDashboard();
    homeController.userAvatar = localSessionManager.userAvatar;
    super.initState();
  }

  Widget _creditScoreWidget({required String creditScore}){
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      decoration:  BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),
          topRight: Radius.circular(15)), color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 4,
            offset: const Offset(0, 22),
          )
        ],
      ),
      child: Row(
        children: [
          RichText(text:
          TextSpan(text: "My Credit Score is ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),
              children: [
                TextSpan(text: creditScore, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.palePurple)),
              ]
          )),
          const Spacing.width(6),
          AppIconButton(
              icon: Image.asset(PNGImages.mediumIcon, height: 20, width: 20,), color: AppColors.palePurple.withOpacity(0.1),
              spacing: 6, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              label: Text("Medium", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
              FontWeight.w500, fontSize: 14.sp, color:  AppColors.black),)),
          const Spacer(),
          GestureDetector(
            onTap: (){
              _kycDialog(context: context);
            },
              child: const Icon(Icons.arrow_forward_outlined, color: AppColors.primaryColor,))
        ],
      ),
    );
  }

   void _seeAll({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(homeController.rowMoreServices.length, (index){
                        final data = homeController.rowMoreServices[index];
                        return ButtonWithLabel(height: 60, width: 60,
                            icon: Image.asset(data["image"]!), title: Text(data["title"]!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xff808A9A), fontWeight: FontWeight.w400, fontSize: 12),));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

      Column(
        children: [
          ...List.generate(homeController.columnMoreServices.length, (index){
            final data = homeController.columnMoreServices[index];
            return AppCustomTile(
              leadingLabel: data["image"],
              titleLabel: data["title"],
              subtitleLabel: data["subtitle"],
              tagLabel: "",
            );
          })
        ],
      )

    ], title: "More Services", height: MediaQuery.of(context).size.height/1.5);
  }

  void _kycDialog({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
         Column(crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Image.asset(PNGImages.vineFlower, height: 150, width: 150,),
             const Spacing.height(24),
             Text("Sorry! You cannot operate this account \nwithout KYC verification", textAlign: TextAlign.center,
               style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.orange, fontSize: 16, fontWeight: FontWeight.w700),),
             const Spacing.width(20),
             Text("Please proceed to verification", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey, fontSize: 16, fontWeight: FontWeight.w400),),
             const Spacing.height(24),
             HalalPrimaryButton(
               btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Verify Now", onTap: (){},
             ),
           ],
         )
    ], title: "Identity Not Verified", height: MediaQuery.of(context).size.height/2);
  }

  void _emailReminderDialog({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(PNGImages.email, height: 150, width: 150,),
          const Spacing.height(32),
          Text("You haven’t added an email to your account", textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w500),),
          const Spacing.width(63),
          HalalPrimaryButton(
            btnHeight: 45, btnWidth: double.maxFinite, btnTitle: "Add Email", onTap: (){},
          ),
          const Spacing.width(8),
          AppFlatButton(label: "I’ll do that later", onPressed: (){
            Navigator.of(context).pop();
          }, textColor: AppColors.primaryColor,),
        ],
      )
    ], title: "Add email", height: MediaQuery.of(context).size.height/2);
  }
  
  
  static void _tier({required BuildContext context}){
    ShowAppBottomSheet().showDismissibleBottomSheet(
        context: context, children: [
      Container(width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 24),
        decoration: const BoxDecoration(color: Color.fromRGBO(222, 236, 255, 0.50)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Account Benefits",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
            FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
            const Spacing.height(16),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Single Transaction",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                    Text("N 200,000",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w700, fontSize: 16.sp, color: const Color(0xff394455))),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Daily Transactions",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                    Text("N 1,000,000",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w700, fontSize: 16.sp, color: const Color(0xff394455))),
                  ],
                ),
              ],
            ),
            const Spacing.height(18),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Single Transaction",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                    Text("N 200,000",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w700, fontSize: 16.sp, color: const Color(0xff394455))),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Ajo",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                    Text("No",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w700, fontSize: 16.sp, color: const Color(0xff394455))),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Loan",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                    Text("No",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w700, fontSize: 16.sp, color: const Color(0xff394455))),
                  ],
                ),
              ],
            ),
            const Spacing.height(18),
            const Divider(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Services",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                FontWeight.w500, fontSize: 16.sp, color: const Color(0xff394455))),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),  color: AppColors.white),
                      child: Center(
                        child: Text("Savings",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w400, fontSize: 16.sp, color: const Color(0xff394455))),
                      ),
                    ),
                    const Spacing.width(10,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.white),
                      child: Center(
                        child: Text("SNBL",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w400, fontSize: 16.sp, color: const Color(0xff394455))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const Spacing.height(37),
      Text("To upgrade your account, "
          "please click on the button "
          "below and you advised to read the "
          "terms and privacy policy of Halal.", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
      FontWeight.w400, fontSize: 16.sp, color: const Color(0xff394455))),
      const Spacing.height(36),
      Container(
        width: double.infinity, height: 45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.primaryColor),
        child: Center(
          child: Text("Upgrade Account",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
          FontWeight.w400, fontSize: 16.sp, color: AppColors.white,)),
        ),
      ),
    ], title: "Tier 1 Account Level", height: MediaQuery.of(context).size.height/1.5);
  }

  Widget _quickAction(){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration( color: AppColors.paleBlue),
      child: GetBuilder<HomeController>(
        init: HomeController(),
          builder: (controller){
        return Stack(
          children: [
            Image.asset(PNGImages.icon, height: 50, width: 50,),
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quick Actions", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                    FontWeight.w500, fontSize: 14.sp, color:  AppColors.black),),
                    GestureDetector(
                      onTap: (){
                        _seeAll(context: context);
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("More Services", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                          FontWeight.w500, fontSize: 14.sp, color:  AppColors.primaryColor, decoration: TextDecoration.underline),),
                          const Icon(Icons.arrow_forward_outlined, color: AppColors.primaryColor, size: 15,)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                        icon: Image.asset(PNGImages.sellPurple, height: 20, width: 20,), color: AppColors.white,
                        onTap: (){
                          ShowAppBottomSheet().showDismissibleBottomSheet(
                              context: context, children: [
                            ...List.generate(controller.sendMoneyTagModels.length, (index){
                              final item = controller.sendMoneyTagModels[index];
                              return AppCustomTile(
                                onTap: (){
                                  if(index == 0){
                                    Navigator.of(context).pop();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const BankTransfer()));
                                  }else if(index == 1){
                                    Navigator.of(context).pop();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const P2PTransfer()));
                                  }else{

                                  }
                                },
                                leadingLabel: item["image"],
                                titleLabel: item["title"],
                                subtitleLabel: item["subTitle"],
                                tagLabel: index == 1 ?  "Free forever" : index == 3 ? "Try for free" : "",
                              );
                            })
                          ], title: "Send Money", height: MediaQuery.of(context).size.height/2.1);
                        },
                        spacing: 3, padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        label: Text("Send Money", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w500, fontSize: 12.sp, color:  AppColors.black),)),
                    AppIconButton(
                        icon: Image.asset(PNGImages.buy, height: 20, width: 20,), color: AppColors.white,
                        onTap: (){
                          ShowAppBottomSheet().showDismissibleBottomSheet(
                              context: context, children: [
                            ...List.generate(controller.sendReceiveTagModels.length, (index){
                              final item = controller.sendReceiveTagModels[index];
                              return AppCustomTile(
                                leadingLabel: item["image"],
                                titleLabel: item["title"],
                                subtitleLabel: item["subTitle"],
                                tagLabel: "",
                              );
                            })
                          ], title: "Receive Money", height: MediaQuery.of(context).size.height/2.2);
                        },
                        spacing: 3, padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        label: Text("Receive Money", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w500, fontSize: 12.sp, color:  AppColors.black),)),
                    AppIconButton(
                        icon: Image.asset(PNGImages.pay, height: 20, width: 20,), color: AppColors.white,
                        onTap: (){
                          ShowAppBottomSheet().showDismissibleBottomSheet(
                              context: context, children: [
                                Text("Airtime & Bills Services", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                FontWeight.w500, fontSize: 16.sp, color:  AppColors.black)),
                            const Spacing.height(10),
                            ...List.generate(controller.airTimeBills.length, (index){
                              final item = controller.airTimeBills[index];
                              return AppCustomTile(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  if(index == 0){
                                    Get.to(()=> const BuyAirtime());
                                  }else if(index == 1){
                                    Get.to(()=> const BuyData());
                                  }else if(index == 2){
                                    Get.to(()=> const BuyElectricityBill());
                                  }else if(index == 3){
                                    Get.to(()=> const BuyCable());
                                  }
                                },
                                leadingLabel: item["image"],
                                titleWidget: Padding(
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: Text(item["title"]!),
                                ),
                                subtitleLabel: item["subTitle"],
                                tagLabel: "",
                              );
                            })
                          ], title: "Airtime & Bills Services", height: MediaQuery.of(context).size.height/1.5);
                        },
                        spacing: 3, padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        label: Text("Airtime & Bills", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                        FontWeight.w500, fontSize: 12.sp, color:  AppColors.black),)),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), color: AppColors.white),
          height: MediaQuery.of(context).size.height/1.5,
          child: Column(
            children: [
              _creditScoreWidget(creditScore: "750"),
              const Spacing.height(20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _quickAction(),
                        Container(
                            color: AppColors.white, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacing.height(20),
                            Image.asset(PNGImages.advertBoard),
                            const Spacing.height(20),
                            Text("Halal Rewards", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                            FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),),
                            const Spacing.height(10),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(width: MediaQuery.of(context).size.width/2.3, height: 120,
                                  padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w,),
                                  decoration: BoxDecoration(border: Border.all(color: AppColors.grey),borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Savings Earning", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                            FontWeight.w500, fontSize: 12.sp, color:  AppColors.black),),
                                            RichText(text:
                                            TextSpan(text: "₦500,000 ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.black),
                                                children: [
                                                  TextSpan(text: "(+124%)", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 8, fontWeight: FontWeight.w700, color: AppColors.palePurple)),
                                                ])),
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Create savings",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                FontWeight.w500, fontSize: 12.sp, color:  AppColors.primaryColor),),
                                                const Icon(Icons.arrow_forward_outlined, color: AppColors.primaryColor, size: 15, ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Positioned(right: 0, bottom: 0,
                                            child: Image.asset(PNGImages.coinBag, width: 70, height: 70,)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(width: MediaQuery.of(context).size.width/2.3, height: 120,
                                  decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w,),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Savings Earning", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                            FontWeight.w500, fontSize: 12.sp, color:  AppColors.black),),
                                            Text("₦1200", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                            FontWeight.w700, fontSize: 16.sp, color:  AppColors.black),),
                                            Row(
                                              children: [
                                                Text("View", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                                FontWeight.w500, fontSize: 12.sp, color:  AppColors.primaryColor),),
                                                const Icon(Icons.arrow_forward_outlined, color: AppColors.primaryColor, size: 15,)
                                              ],
                                            ),
                                          ],
                                        ),
                                        Positioned(right: 0, bottom: 0,
                                            child: Image.asset(PNGImages.coin, width: 70, height: 70,),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacing.height(30),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Transactions", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),),
                                Text("View all", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                                FontWeight.w500, fontSize: 14.sp, color:  AppColors.primaryColor),),
                              ],
                            ),
                            const Spacing.height(18),
                            ...List.generate(4, (index) =>
                                const AppTransactionTile(
                              leadingLabel: PNGImages.mtnLogo, titleLabel: "Airtime to +234 837 2872", subtitleLabel: "₦2,500", tagLabel: "4 days ago",
                            ))
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(PNGImages.icon),)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 22, right: 22, top: 40, bottom: 10),
                width: double.maxFinite, color: AppColors.white,
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50, width: 50,
                      child: Image.asset(homeController.userAvatar == "" ?
                      AppString.aviPath : homeController.userAvatar!,
                      height: 60, width: 60, fit: BoxFit.cover,
                      )),
                  Spacing.width(5.w),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, ", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                          Text(controller.dashBoardResponseModel?.data?.userdetail?.firstName ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black, fontWeight: FontWeight.w700, fontSize: 18),),
                        ],
                      ),
                      Text("Do more with your finances", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                      FontWeight.w500, fontSize: 14.sp, color:  AppColors.grey),)
                    ],
                  ),
                  const Spacing.width(10,),
                  GestureDetector(
                    onTap: (){
                      _tier(context: context);
                    },
                      child: Image.asset(PNGImages.tier1, height: 50, width: 80,)),
                  const Icon(Iconsax.notification_bing_copy)
                ],
              ),
              ),
              const Spacing.height(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Align(alignment: Alignment.centerLeft,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Wallet Balance", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                          FontWeight.w500, fontSize: 12.sp, color:  AppColors.greyValley),),
                          Row(
                            children: [
                              Text("₦500,387.00", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                              FontWeight.w500, fontSize: 20.sp, color:  AppColors.greyValley),),
                              const SizedBox(width: 10,),
                              const Icon(Iconsax.eye_copy, color: AppColors.greyValley, size: 15,)
                            ],
                          ),

                        ],
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Halal-Welfare MFB", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                          FontWeight.w500, fontSize: 12.sp, color:  AppColors.greyValley),),
                          Row(
                            children: [
                              Text("0123456789", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:
                              FontWeight.w500, fontSize: 20.sp, color:  AppColors.greyValley),),
                              const SizedBox(width: 10,),
                              const Icon(Iconsax.copy_copy, color: AppColors.greyValley, size: 15,)
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

