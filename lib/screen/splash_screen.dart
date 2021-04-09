import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/localization/constains.dart';
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
      backgroundColor: AppColor.OffWhite,
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.AppLogo,
              height: ScreenUtil().setHeight(70),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextDisplay(
                  translation: kAppName,
                  color: AppColor.PrimaryColorLight,
                  fontSize: 48,
                ),
                AppTextDisplay(
                  translation: kAppSlogan,
                  color: AppColor.LogoColor,
                  fontSize: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
