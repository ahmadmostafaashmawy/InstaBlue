import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:insta_blue/utilities/localization/app_localizations.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';

class AppEditText extends StatelessWidget {
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final Color borderColor;
  final double fontSize;
  final String text;
  final String translation;
  final FontWeight fontWeight;
  final String fontFamily;
  final double radius;
  TextStyle style;
  TextInputType keyboardType;
  bool isHint;
  final TextAlign textAlign;
  final Widget suffixIcon;
  final Widget prefixIcon;
  EdgeInsets contentPadding;
  final TextDecoration textDecoration;
  final InputDecoration decoration;
  final TextEditingController controller;
  final bool autoFocus;
  final bool alignLabelWithHint;
  final bool enableInteractiveSelection;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final String errorText;
  final bool obscureText;
  final bool readOnly;
  InputBorder border;
  FormFieldValidator<String> validator;

  AppEditText({
    this.textColor = AppColor.White,
    this.backgroundColor = AppColor.Black,
    this.fontSize = 20,
    this.text,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.fontFamily = 'OpenSans',
    this.textDecoration,
    this.borderColor = AppColor.Grey,
    this.focusNode,
    this.radius = 8,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.translation,
    this.isHint = false,
    this.style,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.autoFocus = false,
    this.alignLabelWithHint = false,
    this.enableInteractiveSelection = true,
    this.suffixIcon,
    this.maxLength = 20,
    this.errorText,
    this.obscureText = false,
    this.hintColor = AppColor.GrayPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (contentPadding == null) {
      contentPadding = EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
          vertical: ScreenUtil().setHeight(14));
    }
    if (style != null) {
      double fontSize = style.fontSize;
      style = style.copyWith(fontSize: ScreenUtil().setSp(fontSize));
    }
    init();
    return TextFormField(
      autofocus: autoFocus,
      validator: validator,
      readOnly: readOnly,
      maxLength: maxLength,
      onChanged: onChanged,
      focusNode: focusNode,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      // enableInteractiveSelection: enableInteractiveSelection,
      decoration: decoration != null
          ? decoration
          : InputDecoration(
              contentPadding: contentPadding,
              counterText: "",
              errorText: errorText != null && errorText.isNotEmpty
                  ? AppLocalizations.of(context).translate(errorText)
                  : null,
              // suffixIcon: suffixIcon != null ? suffixIcon : SizedBox(),
              suffix: suffixIcon,
              prefixIcon: prefixIcon,
              border: border,
              enabledBorder: border,
              filled: true,
              hintStyle: new TextStyle(
                color: hintColor,
              ),
              hintText: isHint
                  ? translation != null && translation.isNotEmpty
                      ? AppLocalizations.of(context).translate(translation)
                      : text ?? ''
                  : null,
              alignLabelWithHint: alignLabelWithHint,
              labelText: isHint
                  ? null
                  : translation != null && translation.isNotEmpty
                      ? AppLocalizations.of(context).translate(translation)
                      : text ?? '',
              fillColor: backgroundColor),
      textAlign: textAlign,
      style: style != null
          ? style
          : TextStyle(
              decoration:
                  textDecoration != null ? textDecoration : textDecoration,
              fontSize: ScreenUtil().setSp(fontSize),
              color: textColor,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
    );
  }

  void init() {
    border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: .8),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
