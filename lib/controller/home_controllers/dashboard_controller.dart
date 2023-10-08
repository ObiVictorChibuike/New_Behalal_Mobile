import 'package:behalal/app/universal_utils/state_notifier.dart';
import 'package:behalal/app/universal_utils/validation_mixin.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DashboardController extends StateNotifier with ValidationMixin {
  final PersistentTabController _bottomBarController = PersistentTabController();

  // ignore: unused_field
  var _currentPage = 0;
  bool _hideKYC = false;

  PersistentTabController get bottomBarController => _bottomBarController;
  bool get hideKYC => _hideKYC;

  void onPageChanged(int index) {
    _currentPage = index;
    update();
  }

  void onHideKYC() {
    _hideKYC = true;
    update();
  }

  void checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.withhalal.withhalalmobile",
      iOSId: "com.withhalal.withhalalmobile",
    );
    final status = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
      context: Get.context!,
      versionStatus: status!,
      updateButtonText: 'Yes, update',
      dialogTitle: "App Update Available",
      dismissButtonText: "Remind me later",
      dialogText: "New WithHalal update available on playstore, would you like to update it now?",
    );
    update();
  }
}
