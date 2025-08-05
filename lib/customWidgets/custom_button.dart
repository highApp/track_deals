import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackdeal/constants/colors.dart';

class Button1 extends StatelessWidget {
  final String text;

  const Button1({super.key,
   required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50..h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(text,
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
