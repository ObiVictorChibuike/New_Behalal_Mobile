import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/controller/bills/bills_controller.dart';
import 'package:behalal/controller/home_controllers/dashboard_controller.dart';
import 'package:behalal/controller/home_controllers/home_controller.dart';
import 'package:behalal/controller/transfer_controllers/transfer_controller.dart';
import 'package:behalal/presentation/auth/create_account.dart';
import 'package:behalal/presentation/auth/login_view.dart';
import 'package:behalal/presentation/auth/password_reset.dart';
import 'package:behalal/presentation/onboarding/onboarding_view.dart';
import 'package:behalal/presentation/onboarding/splash_view.dart';
import 'package:behalal/presentation/transfers/bank_transfer_view.dart';
import 'package:behalal/presentation/transfers/p2p_transfer_view.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashView = '/';
  static const String welcomeBackView = '/welcome-back-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String adsView = '/ads-view';
  static const String signUpView = '/signup-view';
  static const String signUpSuccessView = '/signup-success-view';
  static const String onboardingView = '/onboarding-view';
  static const String bvnVerificationView = '/bvn-verification-view';
  static const String dashboardView = '/dashboard-view';
  static const String paymentView = '/payment-view';
  static const String savingsView = '/savings-view';
  static const String savingsPlan = '/savings-plan';
  static const String profileView = '/profile-view';
  static const String accountUpgradeView = '/account-upgrade-view';
  static const String historyView = '/history-view';
  static const String bankTransferView = '/bank-transfer-view';
  static const String topupView = '/topup-view';
  static const String billsPaymentView = '/bills-payment-view';
  static const String savingsOverviewView = '/savings-overview-view';
  static const String savingsDetailsView = '/savings-details-view';
  static const String createPasscodeView = '/create-passcode-view';
  static const String p2pTransferView = '/p2p-transfer-view';
  static const String ajoDashboardView = '/ajo-dashboard-view';
  static const String raiseDashboardView = '/raise-dashboard-view';

  static final List<GetPage> pages = [
    GetPage(
      name: splashView,
      page: () => const SplashView(),
    ),
    GetPage(
      name: onboardingView,
      page: () => OnboardingView(),
    ),
    GetPage(
      name: welcomeBackView,
      page: () => WelcomeBack(),
    ),
    GetPage(
      name: createPasscodeView,
      page: () => CreateTransactionPIN(),
    ),
    GetPage(
      name: signUpView,
      page: () => const CreateAccount(imagePath: "",),
    ),
    GetPage(
      name: loginView,
      page: () => LoginView(),
    ),
    GetPage(
      name: signUpSuccessView,
      page: () => const SignUpSuccessView(),
    ),
    // GetPage(
    //   name: bvnVerificationView,
    //   page: () => BVNVerification(),
    // ),
    // GetPage(
    //   name: homeView,
      // page: () => const HomeView(),
      // binding: BindingsBuilder(() {
      //   Get.put<HomeController>(HomeController());
        // Get.put<ProfileController>(ProfileController());
        // Get.put<SavingsController>(SavingsController());
        // Get.put<KYCController>(KYCController());
        // Get.put<PaymentController>(PaymentController());
        // Get.put<TransactionController>(TransactionController());
    //   }),
    // ),
    // GetPage(
    //   name: dashboardView,
    //   page: () => const DashboardView(),
    //   binding: BindingsBuilder(() {
    //     // Get.put<PaymentService>(PaymentServiceImpl());
    //     // Get.put<PaymentController>(PaymentController());
    //   }),
    // ),
    // GetPage(
    //   name: paymentView,
    //   page: () => const PaymentView(),
    //   // binding: BindingsBuilder.put(() => PaymentController()),
    // ),
    // GetPage(
    //   name: savingsView,
    //   page: () => const SavingsView(),
    // ),
    // GetPage(
    //   name: savingsPlan,
    //   page: () => SavingsPlan(),
    // ),
    // GetPage(
    //   name: profileView,
    //   page: () => const ProfileView(),
    //   binding: BindingsBuilder(() {
    //     // Get.put<ProfileService>(ProfileServiceImpl());
    //     // Get.put<ProfileController>(ProfileController());
    //   }),
    // ),
    // GetPage(
    //   name: historyView,
    //   page: () => const HistoryView(),
    // ),
    GetPage(
      name: bankTransferView,
      page: () => BankTransferView(),
    ),
    // GetPage(
    //   name: topupView,
    //   page: () => TopUpView(),
    // ),
    // GetPage(
    //   name: savingsOverviewView,
    //   page: () => const SavingsOverviewView(),
    // ),
    // GetPage(
    //   name: savingsDetailsView,
    //   page: () => const SavingsDetailsView(),
    // ),
    // GetPage(
    //   name: billsPaymentView,
    //   page: () => BillPaymentView(),
    // ),
    GetPage(
      name: p2pTransferView,
      page: () => P2PTransferView(),
      binding: BindingsBuilder.put(() => TransferController()),
    ),
    // GetPage(
    //   name: ajoDashboardView,
    //   page: () => const AjoDashboard(),
    // ),
    // GetPage(
    //   name: raiseDashboardView,
    //   page: () => const RaiseDashboard(),
    // ),
    // GetPage(
    //   name: accountUpgradeView,
    //   page: () => const AccountUpgradeView(),
    // ),
  ];
}

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );
  }
}
