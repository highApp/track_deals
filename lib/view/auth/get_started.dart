import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/customText.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/home/Navigation.dart';
import 'package:trackdeal/utils/shared_prefs_helper.dart';
import 'package:trackdeal/contoller/authController/model/user_login_data.dart';
import 'package:trackdeal/view/splash2.dart';

import '../../contoller/authController/auth_contorller.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late final AuthController authCont;

  UserLoginData? userData;
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _initializeController();
    _loadUserData();
  }

  void _initializeController() {
    try {
      // Try to find existing controller
      authCont = Get.find<AuthController>();
    } catch (e) {
      // If controller doesn't exist, create it as a singleton
      print('GetStarted: AuthController not found, creating new instance');
      Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      authCont = Get.find<AuthController>();
    }
  }

  Future<void> _loadUserData() async {
    try {
      userData = await SharedPrefsHelper.getUserLoginData();
      if (userData != null) {
        setState(() {
          userName = userData!.firstName ?? userData!.email?.split('@')[0] ?? 'User';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _logout() async {
    authCont.showLogoutConfirmation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // App bar with logout button
              Padding(
                padding: EdgeInsets.only(top: 40..h, right: 20..w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _logout,
                      icon: Icon(Icons.logout, color: AppColors.primaryColor),
                      tooltip: 'Logout',
                    ),
                  ],
                ),
              ),
              SvgPicture.asset('assets/svgIcons/5.svg'),
              SizedBox(height: 20..h,),
              
              // Profile image or default icon
              Container(
                width: 80..w,
                height: 80..w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                child: userData?.profileImage != null && userData!.profileImage!.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          userData!.profileImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 40..sp,
                              color: AppColors.primaryColor,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 40..sp,
                        color: AppColors.primaryColor,
                      ),
              ),
              
              SizedBox(height: 20..h,),
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
                      text: '$userName!',
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
              ),
              // Add bottom padding to ensure content doesn't get cut off
              SizedBox(height: 20..h,),
            ],
          ),
        ),
      ),
    );
  }
}
