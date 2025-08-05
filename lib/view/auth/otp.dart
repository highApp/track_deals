import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/password.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});


  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {


  final FocusNode _usernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30..h,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFF9EA7B8),
                          width: 1,
                        )
                    ),
                    child: SvgPicture.asset('assets/svgIcons/4.svg'),
                  ),
                ),
                SizedBox(height: 35..h,),
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
                SizedBox(height: 35..h,),
                Text('Verify Account',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans'
                  ),
                ),
                SizedBox(height: 20..h,),
                Text('Please type the verification code send to +1111 1111 1111',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(.4),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'PlusJakartaSans'
                  ),
                ),
                SizedBox(height: 20..h,),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Pinput(
                      length: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      submittedPinTheme: PinTheme(
                        width: 55..w,
                        height: 55..h,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(.25),
                                  blurRadius: 20
                              )
                            ]
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 55..w,
                        height: 55..h,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(.25),
                                  blurRadius: 20
                              )
                            ]
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: 55..w,
                        height: 55..h,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(.25),
                                  blurRadius: 2
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20..h,),
                Center(
                  child: Text('Resend Code in : 00:42s',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlusJakartaSans'
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.21,),
                SizedBox(height: 20..h,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Password(),));
                    },
                    child: Button1(text: 'Next'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
