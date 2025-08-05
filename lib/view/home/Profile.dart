import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/utils/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white.withOpacity(.97),
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
                        Text1(text: 'Profile',
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
              SizedBox(height: 25..h,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 1
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text2(text: 'Joined:20/07/25',
                        fontSize: 12..sp,
                          fontWeight: FontWeight.w200,
                          color: Colors.black.withOpacity(.7),
                        ),
                        SvgPicture.asset('assets/svgIcons/31.svg'),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 115..h,
                        width: 115..w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(.1),
                            width: 8
                          ),
                          image: DecorationImage(image: AssetImage('assets/images/image6.png'))
                        ),

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text1(text: 'John smith',
                        fontSize: 20..sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 10..w,),
                        SvgPicture.asset('assets/svgIcons/32.svg'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
