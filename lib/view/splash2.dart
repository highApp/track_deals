import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/login_screen_email.dart';
import 'package:trackdeal/view/auth/login_screen_google.dart';
import 'package:trackdeal/view/auth/sign_in.dart';
import '../constants/colors.dart';
import 'package:flutter_svg/svg.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 5..h,),
              Center(
                child: Text('TrackDeals',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratAlternates'
                  ),
                ),
              ),
              SizedBox(height: 5..h,),
              Text('Welcome',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlusJakartaSans'
                ),
              ),
              Text('sign up to join our community and get free access to the hottest deals from real people.',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlusJakartaSans'
                ),
              ),
              Center(child: SvgPicture.asset('assets/svgIcons/1.svg')),
              SizedBox(height: 15..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreenGoogle()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(.2),
                            blurRadius: 2,
                          ),
                        ]
                      ),
                      child: SvgPicture.asset('assets/svgIcons/2.svg'),
                    ),
                  ),
                  SizedBox(width: 25..w,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreenGoogle()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(17),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(.2),
                              blurRadius: 2,
                            ),
                          ]
                      ),
                      child: SvgPicture.asset('assets/svgIcons/3.svg'),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text('or\nlogin with email',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans'
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreenEmail()));
                  },
                  child: Button1(text: 'Email')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text1(
                    text: 'Already have an account?',
                  color: Color(0xFF6F6F6F),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
                    },
                    child: Text1(text: 'SignIn',
                    color: AppColors.primaryColor,),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
