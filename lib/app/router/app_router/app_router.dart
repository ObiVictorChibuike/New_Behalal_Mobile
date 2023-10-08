import 'package:behalal/app/router/app_router/routes.dart';
import 'package:behalal/app/widgets/error_screen.dart';
import 'package:behalal/controller/auth_controllers/auth_controller.dart';
import 'package:behalal/presentation/auth/confirm_avi_selection.dart';
import 'package:behalal/presentation/auth/create_account.dart';
import 'package:behalal/presentation/auth/forgot_password.dart';
import 'package:behalal/presentation/auth/login_view.dart';
import 'package:behalal/presentation/auth/pick_avatar_avi.dart';
import 'package:behalal/presentation/auth/verify_phone_number.dart';
import 'package:behalal/presentation/dashboard/dashboard_view.dart';
import 'package:behalal/presentation/kyc/create_password.dart';
import 'package:behalal/presentation/kyc/kyc.dart';
import 'package:behalal/presentation/kyc/protect_your_identity.dart';
import 'package:behalal/presentation/auth/setup_passcode.dart';
import 'package:behalal/presentation/onboarding/onboarding_view.dart';
import 'package:behalal/presentation/onboarding/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.onBoardingView:
        return MaterialPageRoute(
          builder: (_) => OnboardingView(),
        );
      case Routes.register:
        var aviPath = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CreateAccount(imagePath: aviPath,),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
      case Routes.otpVerification:
        var fromSignUp = routeSettings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => OTPVerification(fromSignUp: fromSignUp),
        );
      case Routes.kyc:
        return MaterialPageRoute(
          builder: (_) => const KYCScreen(),
        );
      case Routes.createPassword:
        return MaterialPageRoute(
          builder: (_) => const CreatePassword(),
        );
      case Routes.setUpPasscode:
        return MaterialPageRoute(
          builder: (_) => const SetUpPasscode(),
        );
      case Routes.protectIdentity:
        return MaterialPageRoute(
          builder: (_) => const ProtectYourIdentity(),
        );
      case Routes.verifyPhoneNumber:
        var argument = routeSettings.arguments as VerifyOtpScreenArguments;
        return MaterialPageRoute(
          builder: (_) => VerifyPhoneNumber(identifier: argument.identifier ?? "", phoneNumber: argument.phoneNumber ?? "", isFromLogin: argument.isFromLogin,),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const DashBoardView(),
        );
      case Routes.pickAvatarAvi:
        return MaterialPageRoute(
          builder: (_) => const PickAvatarScreen(),
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
        );
      case Routes.confirmAviSelection:
        var aviPath = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>  ConfirmAviSelection(selectedAviPath: aviPath),
        );
    //   case Routes.emailSent:
    //     var message = routeSettings.arguments as String;
    //
    //     return MaterialPageRoute(
    //       builder: (_) => EmailSentScreen(message: message),
    //     );
    //
    //   case Routes.login:
    //     return MaterialPageRoute(
    //       builder: (_) => const LoginScreen(),
    //     );
    //   case Routes.register:
    //     return MaterialPageRoute(
    //       builder: (_) => const RegistrationScreen(),
    //     );
    //
    //   case Routes.resetPassword:
    //     return MaterialPageRoute(
    //       builder: (_) => const ForgotPassword(),
    //     );
    //
    //   case Routes.profile:
    //     var data = routeSettings.arguments as Map<String, String>;
    //     return MaterialPageRoute(
    //       builder: (_) => ProfileDetailsScreen(
    //         data: data,
    //       ),
    //     );
    //
    //   case Routes.home:
    //     return MaterialPageRoute(
    //       builder: (_) => const HomeScreen(),
    //     );
    //   case Routes.contactUs:
    //     return MaterialPageRoute(
    //       builder: (_) => const ContactUsScreen(),
    //     );
    //
    //   case Routes.mediaItemsCenterDetails:
    //     var id = routeSettings.arguments as String;
    //     return MaterialPageRoute(
    //       builder: (_) => MediaCenterDetails(id: id,),
    //     );
    //
    //   case Routes.eventDetails:
    //     var id = routeSettings.arguments as String;
    //     return MaterialPageRoute(
    //       builder: (_) => EventDetails(id: id,),
    //     );
    //   case Routes.projectDetails:
    //     var id = routeSettings.arguments as String;
    //     return MaterialPageRoute(
    //       builder: (_) => ProjectDetails(id: id,),
    //     );
    //
    //   case Routes.menu:
    //     return MaterialPageRoute(
    //       builder: (_) => const MenuScreen(),
    //     );
    //   case Routes.forgotPassword:
    //     return MaterialPageRoute(
    //       builder: (_) => const ChangePassword(),
    //     );
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
    }
  }
}
