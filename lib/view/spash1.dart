
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/view/splash2.dart';
import 'package:trackdeal/view/auth/get_started.dart';
import 'package:trackdeal/utils/shared_prefs_helper.dart';
import 'package:trackdeal/contoller/authController/auth_contorller.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});
  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  Future<void> _checkUserLoginStatus() async {
    // Wait for 3 seconds to show splash screen
    await Future.delayed(Duration(seconds: 3));
    
    print('Splash1: Starting login status check...');
    
    // Check if user is already logged in
    bool isLoggedIn = await SharedPrefsHelper.isLoggedIn();
    print('Splash1: User login status check - isLoggedIn: $isLoggedIn');
    
    // Debug: Print current SharedPreferences status
    await SharedPrefsHelper.debugLoginStatus();
    
    if (mounted) {
      if (isLoggedIn) {
        // User is already logged in, initialize AuthController and navigate to GetStarted
        print('Splash1: User is logged in, initializing AuthController and navigating to GetStarted');
        
        // Initialize AuthController before navigation
        Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
        
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => GetStarted())
        );
      } else {
        // User is not logged in, navigate to Splash2 (normal flow)
        print('Splash1: User is not logged in, navigating to Splash2');
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => Splash2())
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('TrackDeals',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          fontFamily: 'MontserratAlternates'
        ),),
      ),
    );
  }
}
