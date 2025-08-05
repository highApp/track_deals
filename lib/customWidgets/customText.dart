import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackdeal/constants/colors.dart';

class Text1 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const Text1({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.black,
        fontSize: fontSize ?? 14..sp,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontFamily: 'PlusJakartaSans'
      ),
      textAlign: TextAlign.center,
    );
  }
}

class Text2 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const Text2({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? AppColors.black,
          fontSize: fontSize ?? 14..sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontFamily: 'PlusJakartaSans'
      ),
      textAlign: textAlign?? TextAlign.center,
    );
  }
}


