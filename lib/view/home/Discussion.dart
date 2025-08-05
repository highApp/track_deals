import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/drawer.dart';
import 'package:trackdeal/view/home/discussion_detail.dart';

class Discussion extends StatefulWidget {
  const Discussion({super.key});

  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        key: _scaffoldKey,
        drawer: DrawerCustom(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20..h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset('assets/svgIcons/drawer.svg')),
                        SizedBox(width: 15..w,),
                        Text1(text: 'Discussion',
                          fontSize: 20..sp,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgIcons/search.svg'),
                        SizedBox(width: 5..w,),
                        SvgPicture.asset('assets/svgIcons/bell.svg'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30..h,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DiscussionDetail(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 1
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 108..h,
                        width: 108..w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: AssetImage('assets/images/image5.png'))
                        ),
                      ),
                      SizedBox(width: 10..w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text2(text: 'Reward member deals',
                          fontSize: 14..sp,
                          ),
                          SizedBox(height: 5..h,),
                          Text2(text: 'Food & Grocery',
                          fontSize: 10..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 5..h,),
                          Text2(text: 'Posted 6h ago',
                          fontSize: 8,
                              fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.7),
                          ),
                          SizedBox(height: 20..h,),
                          Row(
                            children: [
                              Container(
                                height: 20..h,
                                width: 20..w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/images/image3.png'))
                                ),
                              ),
                              Text1(text: ' William jhonshon',
                                fontSize: 10..sp,
                              ),
                              SizedBox(width: 35..w,),
                              SvgPicture.asset('assets/svgIcons/29.svg'),
                              SvgPicture.asset('assets/svgIcons/30.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: '10',
                                fontSize: 10..sp,
                                color: Color(0xFF666666),
                              )

                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20..h,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiscussionDetail(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 1
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 108..h,
                        width: 108..w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage('assets/images/image5.png'))
                        ),
                      ),
                      SizedBox(width: 10..w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text2(text: 'Reward member deals',
                            fontSize: 14..sp,
                          ),
                          SizedBox(height: 5..h,),
                          Text2(text: 'Food & Grocery',
                            fontSize: 10..sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 5..h,),
                          Text2(text: 'Posted 6h ago',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.7),
                          ),
                          SizedBox(height: 20..h,),
                          Row(
                            children: [
                              Container(
                                height: 20..h,
                                width: 20..w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage('assets/images/image3.png'))
                                ),
                              ),
                              Text1(text: ' William jhonshon',
                                fontSize: 10..sp,
                              ),
                              SizedBox(width: 35..w,),
                              SvgPicture.asset('assets/svgIcons/29.svg'),
                              SvgPicture.asset('assets/svgIcons/30.svg'),
                              SizedBox(width: 5..w,),
                              Text2(text: '10',
                                fontSize: 10..sp,
                                color: Color(0xFF666666),
                              )

                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
