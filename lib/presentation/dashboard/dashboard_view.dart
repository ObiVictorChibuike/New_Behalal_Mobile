import 'package:behalal/app/color/colors.dart';
import 'package:behalal/controller/home_controllers/dashboard_controller.dart';
import 'package:behalal/presentation/savings/savings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../home/home_view.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  late BuildContext testContext;
  final _dashboardController = Get.put(DashboardController());
  int pageIndex = 0;

  @override
  void initState() {
    _dashboardController.checkVersion();
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const SavingScreen(),
      const HomeView(),
      const HomeView(),
      const HomeView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.home_2_copy,
          size: 20,
        ),
        title: "Home",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.wallet_2_copy,
          size: 20,
        ),
        title: "Savings",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Iconsax.camera_copy,
          size: 20,
        ),
        title: "Halal",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.verified_user_outlined,
          size: 20,
        ),
        title: "Takaful",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person_2_outlined,
          size: 20,
        ),
        title: "Profile",
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: PersistentTabView(
            context,
            controller: controller.bottomBarController,
            screens: _buildScreens(),
            items: _navBarsItems(),
            padding: const NavBarPadding.symmetric(
              horizontal: 20,
            ),
            onItemSelected: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            resizeToAvoidBottomInset: true,
            navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight + 10,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: const NavBarDecoration(colorBehindNavBar: Colors.white),
            popActionScreens: PopActionScreensType.all,
            selectedTabScreenContext: (context) {
              testContext = context!;
            },
            popAllScreensOnTapOfSelectedTab: true,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style3,
          ),
        );
      },
    );
  }
}
