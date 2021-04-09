import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_blue/utilities/navigator.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';
import 'package:insta_blue/utilities/resources/app_images.dart';
import 'package:insta_blue/utilities/routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      popAllAndPushName(context, AppRoute.Home);
    });
    return Scaffold(
      backgroundColor: AppColor.PrimaryColor,
      body: Center(
        child: SvgPicture.asset(
          AppImages.AppLogo,
          height: 70,
          width: 30,
        ),
      ),
    );
  }
}
