import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/home/Navigation.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            SizedBox(height: 40..h,),
            SvgPicture.asset('assets/svgIcons/5.svg'),
            SizedBox(height: 30..h,),
            RichText(text: TextSpan(
                text: 'Welcome ',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16..sp,
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: 'John Smith!',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16..sp,
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w700
                    ),
                  ),

                ]
            )),
            SizedBox(height: 10..h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text2(text: 'You are now a part of the app name community.',
              ),
            ),
            SizedBox(height: 10..h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text2(text: 'you can filter and customize your lists of deals, interact with other members, get alerts for deals you want, and much more!',
              ),
            ),
            SizedBox(height: 10..h,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation() ,));
                  },
                  child: Button1(text: 'Get Started')),
            )
          ],
        ),
      ),
    );
  }
}
