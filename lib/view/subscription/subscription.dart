import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';

import '../../customWidgets/customText.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {

  bool check = false;
  bool check2 = false;
  bool check3 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20..h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF9EA7B8),
                              width: 1,
                            )
                        ),
                        child: SvgPicture.asset('assets/svgIcons/4.svg'),
                      ),
                    ),
                    Text2(text: 'Subscription',
                      fontSize: 20..sp,
                    ),
                    Container(width: 50..w,)
                  ],
                ),
                SizedBox(height: 30..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20..w,vertical: 25..h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFB1790),  // Light blue
                        Color(0xFFC12A96),  // Purple
                        Color(0xFF8B3B9C),  // Purple
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 4
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text2(text: 'Basic',
                          fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                check = !check;
                              });
                            },
                            child: Container(
                              height: 20..h,
                              width: 20..w,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(.1)
                              ),
                              child: check ? SvgPicture.asset('assets/svgIcons/up.svg') : SvgPicture.asset('assets/svgIcons/down.svg'),
                            ),
                          )
                        ],
                      ),
                      check ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text2(text: 'Weekly Plan',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text2(text: '29',
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                              Text2(text: ' \$',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                          Text2(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard..',
                          fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )
                        ],
                      ):
                          Container()

                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20..w,vertical: 25..h),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF00C3ED),  // Light blue
                          Color(0xFF007DD2),  // Purple
                          Color(0xFF0050C3),  // Purple
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text2(text: 'Standard',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                check2 = !check2;
                              });
                            },
                            child: Container(
                              height: 20..h,
                              width: 20..w,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(.1)
                              ),
                              child: check2 ? SvgPicture.asset('assets/svgIcons/up.svg') : SvgPicture.asset('assets/svgIcons/down.svg'),
                            ),
                          )
                        ],
                      ),
                      check2 ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text2(text: 'Monthly Plan',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text2(text: '29',
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                              Text2(text: ' \$',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                          Text2(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard..',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )
                        ],
                      ):
                      Container()

                    ],
                  ),
                ),
                SizedBox(height: 20..h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20..w,vertical: 25..h),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFDC613),  // Light blue
                          Color(0xFFFF9209),  // Purple
                          Color(0xFFFE6601),  // Purple
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text2(text: 'Premium',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                check3 = !check3;
                              });
                            },
                            child: Container(
                              height: 20..h,
                              width: 20..w,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(.1)
                              ),
                              child: check3 ? SvgPicture.asset('assets/svgIcons/up.svg') : SvgPicture.asset('assets/svgIcons/down.svg'),
                            ),
                          )
                        ],
                      ),
                      check3 ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text2(text: 'Yearly Plan',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text2(text: '29',
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                              Text2(text: ' \$',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                          Text2(text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard..',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )
                        ],
                      ):
                      Container()

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

