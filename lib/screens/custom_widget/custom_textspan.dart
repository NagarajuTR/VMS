import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextSpan {
  CustomTextSpan._();

  static final instance = CustomTextSpan._();

  TextSpan customTextSpan(
      {String? text,
      Color? color,
      double? textSize,
      FontWeight? fontWeight,
      double? letterSpacing,
      TextAlign? textAlign,
      double? height}) {
    return TextSpan(
      text: text ?? "",
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: textSize ?? ConstSize.instance.textMedium,
          fontWeight: fontWeight ?? FontWeight.normal,
          letterSpacing: letterSpacing ?? 0,
          // fontFamily: 'Nunito',
          height: height),
    );
  }
}
