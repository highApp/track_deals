import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackdeal/constants/colors.dart';

class Button1 extends StatelessWidget {
  final String text;
  final bool isEnabled;

  const Button1({
    super.key,
    required this.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50..h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'PlusJakartaSans'
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
