import 'package:behalal/app/assets/images.dart';
import 'package:behalal/presentation/onboarding/onboarding_view.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var _currentPage = 0;

  final _pages = <OnboardingItem>[
    const OnboardingItem(
        imageUrl: PNGImages.onboard1,
        title: 'Halal made available \nfor everyone.',
        description:
            'Halal is for everyone. From connecting businesses to customers, to making payment transactions faster, enhancing thrift contributions, accessing zero-interest loan and making bill payment easy.'),
    const OnboardingItem(
        imageUrl: PNGImages.onboard2,
        title: 'Grow with Halal, \nhalal for Business.',
        description: 'We help with financial knowledge and setup your product catalog on our E-store, receive payment easily and get zero-interest loans with no-collateral.'),
    const OnboardingItem(
        imageUrl: PNGImages.onboard3,
        title: 'Be an entreprenuer,\nhalal for Students.',
        description: 'Earn money as a student ambassador when you setup thrift groups with friends and peers. Access zero-interest loan as business capital after a long savings.'),
    const OnboardingItem(
        imageUrl: PNGImages.onboard4,
        title: 'Do more withHalal,\nhalal for Traders.',
        description: 'With Halal, you can access zero-interest loan with our daily/weekly thrift contributions and reduce the risk of fraud, theft and loss in local Ajo/Esusu/Adashe.'),
  ];

  int get currentPage => _currentPage;

  List<OnboardingItem> get pages => _pages;

  void onPageChanged(int index) {
    _currentPage = index;
    update();
  }
}
