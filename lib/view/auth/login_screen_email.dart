import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/otp.dart';

import '../../contoller/authController/auth_contorller.dart';

class LoginScreenEmail extends StatefulWidget {
  const LoginScreenEmail({super.key});


  @override
  State<LoginScreenEmail> createState() => _LoginScreenEmailState();
}

class _LoginScreenEmailState extends State<LoginScreenEmail> {
  late AuthController authCont;
  final FocusNode _usernameFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
    
    // Initialize AuthController if it doesn't exist
    try {
      authCont = Get.find<AuthController>();
    } catch (e) {
      // If AuthController doesn't exist, create it as a singleton
      Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      authCont = Get.find<AuthController>();
    }
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Email validation function
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Handle next button click
  void _handleNextButtonClick() {
    final email = _emailController.text.trim();
    
    // Print email value
    print('Email entered: $email');
    
    // Validate email
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      return;
    }
    
    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }
    
    // Clear any previous errors
    setState(() {
      _emailError = null;
    });
    
    // Navigate to OTP screen with email parameter
    //Get.to(() => OTP(email: email));
    // Navigate to OTP screen
    authCont.sendEmailOTPCode(email);
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
                Text('Login with email',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans'
                  ),
                ),
                SizedBox(height: 20..h,),
                Focus(
                  onFocusChange: (hasFocus){
                    setState(() {});
                  },
                  child: TextField(
                    controller: _emailController,
                    focusNode: _usernameFocusNode,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always, // Always float
                      labelStyle: TextStyle(
                        color: _usernameFocusNode.hasFocus ? AppColors.primaryColor : Color(0xFF6F6F6F),
                      ),
                      errorText: _emailError,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _emailError != null ? Colors.red : Color(0xFF6F6F6F),
                          width: 1, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: _emailError != null ? Colors.red : AppColors.primaryColor,
                          width: 1, // Border width on focus
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10, // Field height control
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.36,),
                SizedBox(height: 20..h,),
                GestureDetector(
                    onTap: _handleNextButtonClick,
                    child: Button1(text: 'Next'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
