import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:trackdeal/constants/colors.dart';
import 'package:trackdeal/customWidgets/custom_button.dart';
import 'package:trackdeal/view/auth/get_started.dart';
import 'dart:async';

import '../../contoller/authController/auth_contorller.dart';

class OTP extends StatefulWidget {
  final String email;
  
  const OTP({super.key, required this.email});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> with WidgetsBindingObserver {

  late final AuthController authCont;
  final FocusNode _usernameFocusNode = FocusNode();
  final TextEditingController _otpController = TextEditingController();
  Timer? _timer;
  int _countdown = 120; // 2 minutes in seconds
  bool _isDialogOpen = false; // Track if loading dialog is open

  // Show loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _isDialogOpen = true; // Set dialog open state
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
                SizedBox(height: 20),
                Text(
                  'Verifying OTP...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hide loading dialog
  void _hideLoadingDialog() {
    Navigator.of(context).pop();
    _isDialogOpen = false; // Set dialog open state to false
  }

  // Handle next button click
  void _handleNextButtonClick() async {
    final otp = _otpController.text.trim();
    final email = widget.email;
    
    // Validate OTP
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show loading dialog
    _showLoadingDialog();
    
    try {
      // Call the verify OTP method
      await authCont.verifyOtp(email, otp);
      // The AuthController will handle navigation and hide the dialog
    } catch (e) {
      _hideLoadingDialog();
      String errorMessage = 'An error occurred. Please try again.';
      
      // Provide more specific error messages based on the error type
      if (e.toString().contains('timeout')) {
        errorMessage = 'Request timeout. Please check your internet connection.';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (e.toString().contains('server')) {
        errorMessage = 'Server error. Please try again later.';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
    WidgetsBinding.instance.addObserver(this);
    _usernameFocusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
    _startTimer();
  }

  void _initializeController() {
    try {
      authCont = Get.find<AuthController>();
    } catch (e) {
      // If controller doesn't exist, create it as a singleton
      print('OTP: AuthController not found, creating new instance');
      Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
      authCont = Get.find<AuthController>();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resendCode() {
    setState(() {
      _countdown = 120; // Reset to 2 minutes
    });
    _startTimer();
    // Add your resend code logic here
  }

  String _formatTime() {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _usernameFocusNode.dispose();
    _otpController.dispose();
    _timer?.cancel();
    // Close loading dialog if it's still open
    if (_isDialogOpen) {
      _hideLoadingDialog();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Close loading dialog if app goes to background
      if (_isDialogOpen) {
        _hideLoadingDialog();
      }
    }
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
                  onTap: () {
                    if (authCont.isVerifyingOtp) {
                      // Show confirmation dialog if verification is in progress
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Verification in Progress'),
                            content: Text('Are you sure you want to go back? This will cancel the OTP verification.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close dialog
                                  Navigator.of(context).pop(); // Go back
                                },
                                child: Text('Go Back'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: authCont.isVerifyingOtp 
                          ? Color(0xFF9EA7B8).withOpacity(0.5)
                          : Color(0xFF9EA7B8),
                        width: 1,
                      )
                    ),
                    child: SvgPicture.asset(
                      'assets/svgIcons/4.svg',
                      colorFilter: authCont.isVerifyingOtp 
                        ? ColorFilter.mode(
                            Color(0xFF9EA7B8).withOpacity(0.5), 
                            BlendMode.srcIn
                          )
                        : null,
                    ),
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
                Text('Verify Otp',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans'
                  ),
                ),
                SizedBox(height: 20..h,),
                Text('Please type the verification code send to your email',
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
                      controller: _otpController,
                      length: 6,
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
                GetBuilder<AuthController>(
                  builder: (controller) => GestureDetector(
                    onTap: _countdown == 0 && !controller.isVerifyingOtp ? _resendCode : null,
                    child: Text(
                      _countdown > 0 
                        ? 'Resend Code in : ${_formatTime()}s'
                        : 'Resend Code',
                      style: TextStyle(
                        color: _countdown > 0 || controller.isVerifyingOtp
                          ? AppColors.black.withOpacity(.8)
                          : AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlusJakartaSans'
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.21,),
                SizedBox(height: 20..h,),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    // Close loading dialog if verification failed or completed
                    if (!controller.isVerifyingOtp && _isDialogOpen) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _hideLoadingDialog();
                      });
                    }
                    
                    return GestureDetector(
                      onTap: controller.isVerifyingOtp ? null : _handleNextButtonClick,
                      child: Button1(
                        text: controller.isVerifyingOtp ? 'Verifying...' : 'Next',
                        isEnabled: !controller.isVerifyingOtp,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
