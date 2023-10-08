import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  const SupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Support',
        dashboard: false,
        whiteBG: true,
        bgColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We would love to help.',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacing.height(20),
              Text(
                'Any Issues? Please feel free to use any of the means below to reach us.',
                style: TextStyle(
                  color: const Color(0xff003780),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacing.height(15),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => _launchURL('tel://08102837968'),
                      child: const SupportWidget(
                        icon: Icons.phone,
                        title: 'Call us now',
                        subTitle: '08102837968',
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => _launchURL('tel://08102837968'),
                      child: const SupportWidget(
                        icon: Icons.favorite,
                        title: 'Chat on Whatsapp',
                        subTitle: '08102837968',
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => _launchURL('mailto://support@withhalal.com'),
                      child: const SupportWidget(
                        icon: Icons.email,
                        title: 'Send Email',
                        subTitle: 'support@withhalal.com',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing.height(35),
              Center(
                child: Text(
                  'Reach us on social media',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacing.height(25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _launchURL('https://twitter.com/withhalal');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SvgPicture.asset(SVGImages.twitter),
                    ),
                  ),
                  const Spacing.width(35),
                  InkWell(
                    onTap: () {
                      _launchURL('https://instagram.com/withhalal');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SvgPicture.asset(SVGImages.ig),
                    ),
                  ),
                  const Spacing.width(35),
                  InkWell(
                    onTap: () {
                      _launchURL('https://m.facebook.com/withhalalHQ/');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SvgPicture.asset(SVGImages.fb),
                    ),
                  ),
                  const Spacing.width(35),
                  InkWell(
                    onTap: () {
                      _launchURL('https://www.linkedin.com/company/withhalal/');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SvgPicture.asset(SVGImages.linkedin),
                    ),
                  ),
                ],
              ),
              const Spacing.height(35),
              // Text(
              //   'We would love to hear from you',
              //   style: TextStyle(
              //     color: AppColors.primaryColor,
              //     fontSize: 15.sp,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // const Spacing.height(25),
              // const AppTextField(
              //   maxLines: 5,
              // )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SupportWidget extends StatelessWidget {
  const SupportWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              icon,
              size: 35,
            ),
            backgroundColor: const Color(0xffCCE4FF),
          ),
          const Spacing.width(25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacing.height(8),
              Text(
                subTitle,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
