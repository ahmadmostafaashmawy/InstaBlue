import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:insta_blue/utilities/localization/app_localizations.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';

class AppTextDisplay extends StatelessWidget {
  final Color color;
  final double fontSize;
  String text;
  String translation;
  final FontWeight fontWeight;
  final String fontFamily;
  TextStyle style;
  final TextAlign textAlign;
  final bool isUpper;
  final bool softWrap;
  final int maxLines;
  final TextOverflow overflow;
  final TextDecoration decoration;

  AppTextDisplay(
      {this.color = AppColor.Black,
      this.fontSize = 15.0,
      this.text,
      this.fontFamily = 'OpenSans',
      this.decoration,
      this.translation,
      this.overflow = TextOverflow.ellipsis,
      this.style,
      this.softWrap = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.center,
      this.fontWeight = FontWeight.normal,
      this.isUpper = false});

  @override
  Widget build(BuildContext context) {
    if (isUpper) {
      text = text?.toUpperCase();
      translation = translation?.toUpperCase();
    }
    if (style != null) {
      double fontSize = style.fontSize;
      style = style.copyWith(fontSize: ScreenUtil().setSp(fontSize));
    }
    return Text(
      translation != null && translation.isNotEmpty
          ? AppLocalizations.of(context).translate(translation)
          : text ?? '',
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: style != null
          ? style
          : TextStyle(
              decoration: decoration,
              color: color,
              fontSize: ScreenUtil().setSp(fontSize),
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }
}
