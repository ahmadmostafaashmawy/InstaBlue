import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';

class AppButtonDisplay extends StatelessWidget {
  final String translation;
  final Color color;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextDecoration textDecoration;
  final BoxDecoration decoration;
  TextStyle style;
  Function onTap;
  final Widget child;
  BorderRadiusGeometry border;
  final IconData iconData;
  final bool isUpper;

  AppButtonDisplay({
    this.translation,
    this.color = AppColor.PrimaryRedColor,
    this.textColor = AppColor.White,
    this.onTap,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'OpenSans',
    this.textDecoration,
    this.border,
    this.child,
    this.decoration,
    this.iconData,
    this.isUpper = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(12),
            horizontal: ScreenUtil().setWidth(16)),
        decoration: decoration != null
            ? decoration
            : BoxDecoration(
                color: color,
                borderRadius: border != null
                    ? border
                    : BorderRadius.horizontal(),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) Icon(iconData, size: 24, color: textColor),
            child != null
                ? child
                : AppTextDisplay(
                    translation: translation,
                    isUpper: isUpper,
                    style: style != null
                        ? style
                        : TextStyle(
                            decoration: textDecoration,
                            color: textColor,
                            fontSize: fontSize,
                            fontFamily: fontFamily,
                            fontWeight: fontWeight),
                  ),
          ],
        ),
      ),
    );
  }
}
